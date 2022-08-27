class Wishlist < ApplicationRecord
  belongs_to :variant
  belongs_to :user

  class << self
    def with_variant
      includes(
        variant: [
          :translations,
          :images,
          :color,
          { product: %i[translations category] }
        ]
      )
    end
  end
end
