class WishlistsController < ApplicationController
  layout 'app'

  def show
    authorize Wishlist

    respond_to do |format|
      format.html
      format.json do
        @variants = Wishlist.includes(:variant).where(user: Current.user, variants: { state: [:active] }).map(&:variant)
      end
    end
  end
end
