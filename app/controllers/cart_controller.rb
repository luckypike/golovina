class CartController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_sizes, only: [:show]

  def show
    authorize :cart

    @items = Cart.where(user: current_user)
    @order = Order.where(state: :undef, user: current_user).first_or_create!
    @user = current_user
  end

  def destroy
    authorize :cart
    cart = Cart.where(id: params[:id], user: current_user)
    if cart
      cart.destroy_all
    end
    head :ok
  end
end
