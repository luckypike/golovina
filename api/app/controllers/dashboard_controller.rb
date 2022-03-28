class DashboardController < ApplicationController
  before_action :authorize_dashboard
  before_action :set_user, only: %i[user]

  def index
    @orders = Order.paid.includes(:user).with_items.order(payed_at: :desc)
  end

  def archived
    @orders = Order.archived.includes(:user).with_items.order(payed_at: :desc)
      .where("payed_at > ?", 1.year.ago)
  end

  def cart
    @orders = Order.cart.includes(:user).with_items
      .where('updated_at > ?', Time.current - 3.months)
      .order(updated_at: :desc)
  end

  def wishlists
    @wishlists = Wishlist.with_variant.includes(:user)
      .where('created_at > ?', 3.months.ago)
      .order(created_at: :desc)
  end

  def catalog
    @items = (Category.all + Theme.all).sort_by(&:weight)
  end

  def catalog_update
    params[:items].each do |item|
      item[:type].constantize.find(item[:id]).update(weight: item[:weight])
    end
  end

  def users
    @users = User.common.includes(:orders)
  end

  def user
    respond_to do |format|
      format.html do
        @addresses = @user.user_addresses
      end

      format.json do
        @orders = @user.orders.not_cart
          .with_items.order(payed_at: :desc)

        @refunds = @user.refunds
          .with_items.order(id: :desc)
      end
    end
  end

  # def variants
  #   @item = params[:type].constantize.find(params[:id])
  #
  #   @variants =
  #     if @item.is_a?(Category)
  #       if params[:archived]
  #         @item.variants.archived.order(weight: :asc)
  #       else
  #         @item.variants.not_archived.order(weight: :asc)
  #       end
  #     elsif @item.is_a?(Theme)
  #       if params[:archived]
  #         Variant.archived.select('variants.*, themables.weight').joins(:themables)
  #           .where(themables: { theme: @item }).for_list.order('themables.weight ASC')
  #       else
  #         Variant.not_archived.select('variants.*, themables.weight').joins(:themables)
  #           .where(themables: { theme: @item }).for_list.order('themables.weight ASC')
  #       end
  #     end
  # end

  # def variants_update
  #   @item = params[:item][:type].constantize.find(params[:item][:id])
  #
  #   if @item.is_a?(Category)
  #     params[:variants].each do |variant|
  #       Variant.find(variant[:id]).update(weight: variant[:weight])
  #     end
  #   elsif @item.is_a?(Theme)
  #     params[:variants].each do |variant|
  #       @item.themables.find_by(variant: variant[:id]).update(weight: variant[:weight])
  #     end
  #   end
  # end

  def items
    @item = params[:type].constantize.find(params[:id])

    @items =
      if @item.is_a?(Category)
        if params[:archived]
          (
            @item.variants.archived.order(weight: :asc) +
            @item.kits.archived.order(weight: :asc)
          ).sort_by(&:weight)
        else
          (
            @item.variants.not_archived.order(weight: :asc) +
            @item.kits.not_archived.order(weight: :asc)
          ).sort_by(&:weight)
        end
      elsif @item.is_a?(Theme)
        if params[:archived]
          Variant.archived.select('variants.*, themables.weight').joins(:themables)
            .where(themables: { theme: @item }).for_list.order('themables.weight ASC')
        else
          Variant.not_archived.select('variants.*, themables.weight').joins(:themables)
            .where(themables: { theme: @item }).for_list.order('themables.weight ASC')
        end
      end
  end

  def items_update
    @item = params[:item][:type].constantize.find(params[:item][:id])

    if @item.is_a?(Category)
      params[:items].each do |i|
        i[:type].constantize.find_by(id: i[:id]).update(weight: i[:weight])
      end
    elsif @item.is_a?(Theme)
      params[:items].each do |i|
        @item.themables.find_by(variant: i[:id]).update(weight: i[:weight])
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_dashboard
    authorize :dashboard
  end
end
