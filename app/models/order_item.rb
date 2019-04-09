class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :variant
  belongs_to :size

  def price_sell
    price.present? ? price * quantity : variant.price_sell * quantity rescue 0
  end

  def available
    variant.availabilities.active.where(size: size).sum(&:quantity)
  end

  def available?
    available >= quantity
  end
end
