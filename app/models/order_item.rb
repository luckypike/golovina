class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :variant
  belongs_to :size
  belongs_to :refund, optional: true

  validates :quantity, presence: true

  def price_sell
    variant.price_sell * quantity
  end

  def available
    variant.availabilities.active.where(size: size).sum(&:quantity)
  end

  def available?
    available >= quantity
  end

  class << self
    def with_variant
      includes(
        variant: [
          :images,
          :translations,
          :availabilities,
          color: :translations,
          product: %i[translations category]
        ]
      )
    end

    def with_size
      includes(
        :size
      )
    end
  end
end
