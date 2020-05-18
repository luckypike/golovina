class Wishlist < ApplicationRecord
  belongs_to :variant
  belongs_to :user

  class << self
    def with_variant
      includes(
        variant: [
          :translations,
          :images,
          product: %i[translations category variants]
        ]
      )
    end
  end
end
