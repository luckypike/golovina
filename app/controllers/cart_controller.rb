class CartController < ApplicationController
  include ProductsHelper
  include ActionView::Helpers::NumberHelper

  before_action :set_cart, only: [:destroy]
  before_action :set_user, only: [:index]

  layout 'app'

  def index
    authorize Cart

    respond_to do |format|
      format.html
      format.json do
        @carts = Cart.includes(:size, { variant: [:color, :availabilities] }).where(user: Current.user)
        @user = Current.user
      end
    end
  end

  # def discount
  #   authorize :cart
  #
  #   if params[:phone].present?
  #     phone = params[:phone]
  #     existing_user = User.find_by(phone: phone)
  #     discount = Discount.find_by(phone: phone)
  #
  #     if existing_user.present?
  #       render layout: false
  #     else
  #       discount.present? ? current_user.discount = discount : current_user.discount = nil
  #
  #       @user = current_user
  #       @items = Cart.where(user: current_user)
  #       @sum = @items.map{ |i| (i.variant.discount_price(@user.get_discount)) * i.quantity }.sum
  #       !current_user.discount.nil? ? @discount_size = number_to_percentage(current_user.discount.size * 100, precision: 0) : @discount_size = nil
  #       render json: {total: "Товаров на сумму: #{number_to_rub(@sum)}", discount: @discount_size}
  #     end
  #   else
  #     render layout: false
  #   end
  #
  # end

  def destroy
    authorize @cart

    if @cart.quantity > 1
      @cart.quantity -= 1
      @cart.save
    else
      @cart.destroy
    end



    head :ok
  end

  private
  def set_cart
    @cart = Cart.find(params[:id])
  end
end
