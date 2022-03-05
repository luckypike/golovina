# frozen_string_literal: true

module Api
  class CartsController < Api::ApplicationController
    before_action :authorize_cart
    before_action :set_order, only: %i[checkout delivery delete_order_item]

    def show
      @cmd = Carts::ShowCmd.call(user: current_user)
    end

    def apply_promo_code
      Carts::PromoCodes::ApplyCmd.call(user: current_user, promo_code_params: params)
    end

    def delete_promo_code
      Carts::PromoCodes::DeleteCmd.call(user: current_user)
    end

    def delete_order_item
      @order_item = @order.order_items.find(params[:id])
      Carts::DeleteOrderItemCmd.call(order_item: @order_item)
    end

    def checkout
      Carts::CheckoutCmd.call(order: @order, checkout_params: params)
    end

    def delivery
      Carts::DeliveryCmd.call(order: @order, delivery_params: params)
    end

    private

    def authorize_cart
      authorize %i[api cart]
    end

    def set_order
      @order = Api::Order.state_cart.find_by!(user_id: current_user.id)
    end
  end
end
