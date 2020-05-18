class WishlistsController < ApplicationController
  def show
    authorize Wishlist

    respond_to do |format|
      format.html
      format.json do
        @variants = Wishlist.with_variant
          .where(user: current_user, variants: { state: [:active] })
          .order(created_at: :asc)
          .map(&:variant)
      end
    end
  end
end
