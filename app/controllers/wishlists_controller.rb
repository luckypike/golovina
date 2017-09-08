class WishlistsController < ApplicationController
  def show
    authorize :wishlist, :show?
    @items = Wishlist.where(user: current_user)
  end
end
