# frozen_string_literal: true

class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :paid

  before_action :set_order, only: %i[archive unarchive]
  before_action :authorize_order

  def archive
    if @order.paid?
      @order.archive!
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def unarchive
    if @order.can_unarchive?
      @order.unarchive!
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def paid
    if Digest::MD5.hexdigest(params.slice(:id, :sum, :clientid, :orderid).values.push(Figaro.env.paykeeper_secret_key!).join('')) == params[:key]
      order = Order.find(params[:orderid])

      if order.cart?
        order.update(payment_id: params[:id], payment_amount: params[:sum])
        order.pay!
      end

      if order.paid?
        render inline: ('OK ' + Digest::MD5.hexdigest(params[:id] + Figaro.env.paykeeper_secret_key!))
      else
        head :ok
      end
    else
      head :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def authorize_order
    authorize @order || Order
  end

  def order_params
    params.require(:order).permit(
      :user_address_id,
      :delivery, :delivery_option, :delivery_city_id,
      :tracker_id, :tracker_type,
      :country, :city, :zip,
      :street, :house, :appartment,
      :comment, :gift,
      user_attributes: %i[name sname email phone]
    )
  end
end
