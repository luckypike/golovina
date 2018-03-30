require 'sms'

class OrdersController < ApplicationController
  before_action :set_sizes, only: [:index]
  before_action :set_order, only: [:checkout, :pay, :archive]
  skip_before_action :verify_authenticity_token, only: [:paid]

  def index
    authorize Order
    @orders = Order.includes(:user, order_items: { variant: [ { product: [:images, :category] }, :color, :images ]}).where.not(state: [:undef]).order(created_at: :desc)
    @orders = @orders.where(state: params[:state]) if params[:state]
  end

  def checkout
    authorize @order

    errors = {}
    @cart.each_with_index do |item, index|
      if !item.variant.purchasable(item.size, item.quantity)
        errors[index] = {quantity: item.variant.avail_quantity(item.size)}
      end
    end

    render json: { error: errors, status: :unpurchasable } and return if !errors.blank?

    @user = current_user

    if params[:user]
      params[:user][:email] = @user.email if params[:user][:email].empty?


      if @user.update(phone: params[:user][:phone], email: params[:user][:email], name: params[:user][:name], s_name: params[:user][:s_name])
      else
        render json: { error: @user.errors, status: :unprocessable_entity } and return
      end
    end

    unless @order.user.reload.is_guest?
      @cart.each do |item|
        @order.order_items.build(variant: item.variant, quantity: item.quantity, size: item.size, price: item.variant.product.price_sell)
        item.destroy
      end

      @order.save
      @order.activate!
      @order.update_attribute(:address, params[:order][:address])

      head :ok, location: [:pay, @order]
    end
  end

  def pay
    authorize @order

    if !@order.purchasable
      redirect_to [:orders, current_user], notice: 'Неверный заказ' and return
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

    if Digest::MD5.hexdigest(params.slice(:id, :sum, :clientid, :orderid).values.push(Rails.application.secrets[:payment_key]).join('')) == params[:key]
      order = Order.find(params[:orderid])
      order.update(payment_id: params[:id], payment_amount: params[:sum])
      order.pay!

      render inline: ('OK ' + Digest::MD5.hexdigest(params[:id] + Rails.application.secrets[:payment_key]))
    end
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

end
