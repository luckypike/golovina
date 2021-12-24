class OrderItemsController < ApplicationController
  def destroy
    @order_item = OrderItem.find(params[:id])
    authorize @order_item

    @order = @order_item.order

    if @order_item.quantity > 1
      @order_item.quantity -= 1
      @order_item.save
    else
      @order_item.destroy
    end

    respond_to do |format|
      format.json do
        render json: { quantity: @order.quantity }, status: :ok
      end
    end
  end
end
