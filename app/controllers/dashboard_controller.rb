class DashboardController < ApplicationController
  before_action :authorize_dashboard

  def index
    @orders = Order.paid.includes(:user).with_items.order(payed_at: :desc)
  end

  def archived
    @orders = Order.archived.includes(:user).with_items.order(payed_at: :desc)
  end

  def cart
    @orders = Order.cart.includes(:user).with_items
      .where('updated_at > ?', Time.current - 3.months)
      .order(updated_at: :desc)
  end

  def refunds
    @refunds = Refund.includes(:user).with_items.order(id: :desc)
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

  def variants
    @variants = params[:type].constantize.find(params[:id])
      .variants.not_archived.order(weight: :asc)
  end

  def variants_update
    @item = params[:item][:type].constantize.find(params[:item][:id])

    if @item.is_a?(Category)
      params[:variants].each do |variant|
        Variant.find(variant[:id]).update(weight: variant[:weight])
      end
    elsif @item.is_a?(Theme)
    end
    pp params
  end

  private

  def authorize_dashboard
    authorize :dashboard
  end
end
