class AccountsController < ApplicationController
  before_action :authorize_account

  def show
    respond_to do |format|
      format.html
      format.json do
        # @orders = Order.not_cart
        #   .with_items.order(payed_at: :desc)
        #   .limit(200)
        @orders = current_user.orders.not_cart
          .with_items.order(payed_at: :desc)

        @cart = current_user.orders.cart.first
      end
    end
  end

  private

  def authorize_account
    authorize :account
  end
end
