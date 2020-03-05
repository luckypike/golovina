require 'sms'

class OrdersController < ApplicationController
  before_action :set_order, only: [:checkout, :pay, :archive]
  skip_before_action :verify_authenticity_token, only: [:paid]

  def index
    authorize Order

    respond_to do |format|
      format.html
      format.json do
        @orders = Order
          .includes(
            :user,
            :delivery_city,
            order_items: [
              :size,
              variant: [
                { color: [{ colors: :translations }, :translations] },
                :translations
              ]
            ]
          ).where.not(state: [:undef]).where.not(user: nil)
          .order(created_at: :desc)
        @orders = @orders.where(state: params[:state]) if params[:state]
      end
    end
  end

  def create
    authorize Order

    @order = Order.new(user: Current.user)
    @order.assign_attributes(order_params)

    @order.promo = Order::PROMO if Order::PROMO

    if (existed_user = User.find_for_authentication(email: order_params[:user_attributes][:email]))
      User.destroy_old_user existed_user if existed_user != current_user
    end

    Current.user.carts.each do |cart|
      @order.order_items.build(variant: cart.variant, quantity: cart.quantity, size: cart.size)
    end

    if @order.save
      @order.activate!
      Current.user.carts.destroy_all
      head :ok, location: orders_user_path(@order.user)
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def pay
    authorize @order

    unless @order.purchasable?
      redirect_to orders_user_path(current_user, :order => @order.id), notice: 'Неверный заказ' and return
    end

    render layout: false
  end

  def archive
    authorize @order
    @order.archive!
    head :ok
  end

  def paid
    authorize Order

    if Digest::MD5.hexdigest(params.slice(:id, :sum, :clientid, :orderid).values.push(Rails.application.credentials[Rails.env.to_sym][:payment][:key]).join('')) == params[:key]
      order = Order.find(params[:orderid])

      if order.active?
        order.update(payment_id: params[:id], payment_amount: params[:sum])
        order.pay!
      end

      if order.paid?
        render inline: ('OK ' + Digest::MD5.hexdigest(params[:id] + Rails.application.credentials[Rails.env.to_sym][:payment][:key]))
      else
        head :ok
      end
    else
      head :unprocessable_entity
    end
  end

  def carts
    authorize Order

    @carts = Cart.includes(:user).last(100).reverse
  end

  def subscribers
    authorize Order

    @subscribers = Notification.includes(:variant, :user).order(created_at: :desc).all
  end

  private

  def order_params
    params.require(:order).permit(
      :delivery,
      :delivery_option,
      :delivery_city_id,
      :address,
      :phone,
      user_attributes: [
        :name, :sname, :email
      ]
    )
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
