class CartController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    authorize :cart

    @items = Cart.where(user: current_user)
    @order = Order.where(state: :undef, user: current_user).first_or_create!
    @user = current_user
  end
end
