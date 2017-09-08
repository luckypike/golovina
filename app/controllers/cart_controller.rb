class CartController < ApplicationController
  def show
    authorize :cart
    @items = Cart.where(user: current_user)
  end
end
