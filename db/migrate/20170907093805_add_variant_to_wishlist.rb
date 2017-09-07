class AddVariantToWishlist < ActiveRecord::Migration[5.1]
  def change
    add_reference :wishlists, :variant, foreign_key: true
    remove_reference :wishlists, :product
  end
end
