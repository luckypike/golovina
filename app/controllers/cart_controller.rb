class CartController < ApplicationController
  def show
    authorize Cart
    @items = Cart.where(user: current_user)
  end
end
