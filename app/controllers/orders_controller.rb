class OrdersController < ApplicationController
  def checkout
    @order = Order.find(params[:id])
    authorize @order

    @user = current_user

    if params[:user]
      params[:user][:email] = @user.email if params[:user][:email].empty?


      if @user.update(phone: params[:user][:phone], email: params[:user][:email], name: params[:user][:name])
      else
        render json: { error: @user.errors, status: :unprocessable_entity }
      end
    end

    unless @order.user.reload.is_guest?
      @cart.each do |item|
        @order.order_items.build(variant: item.variant, quantity: item.quantity, size: item.size)
        item.destroy
      end
      @order.save

      @order.active!
      @order.update_attribute(:address, params[:order][:address])
      OrderMailer.checkout(@order).deliver_now
    end
  end
end
