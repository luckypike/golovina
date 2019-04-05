class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :variant
  belongs_to :size

  def price_sell
    price.present? ? price * quantity : variant.price_sell * quantity
  end

  def available?
    variant.availabilities.active.where(size: size).sum(&:count) >= quantity
  end
end
