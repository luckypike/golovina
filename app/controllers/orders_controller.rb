require 'sms'

class OrdersController < ApplicationController
  before_action :set_order, only: [:checkout, :pay, :archive]
  skip_before_action :verify_authenticity_token, only: [:paid]

  layout 'app'

  def index
    authorize Order

    respond_to do |format|
      format.html
      format.json do
        @orders = Order.includes(:user, order_items: { variant: [ { product: [:images, :category] }, :color, :images ]}).where.not(state: [:undef]).order(created_at: :desc)
        @orders = @orders.where(state: params[:state]) if params[:state]
      end
    end
  end

  def create
    authorize Order

    @order = Order.new(user: Current.user)
    @order.assign_attributes(order_params)

    Current.user.carts.each do |cart|
      @order.order_items.build(variant: cart.variant, quantity: cart.quantity, size: cart.size)
    end

    if @order.save
      @order.activate!
      Current.user.carts.destroy_all
      head :ok, location: pay_order_path(@order)
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

    if Digest::MD5.hexdigest(params.slice(:id, :sum, :clientid, :orderid).values.push(Rails.application.credentials.payment[:key]).join('')) == params[:key]
      order = Order.find(params[:orderid])
      order.update(payment_id: params[:id], payment_amount: params[:sum])
      order.pay!

      render inline: ('OK ' + Digest::MD5.hexdigest(order.id + Rails.application.credentials.payment[:key]))
    end
  end

  private
  def order_params
    params.require(:order).permit(
      :address,
      user_attributes: [
        :name, :s_name, :phone, :email
      ]
    )
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
