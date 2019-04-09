class Cart < ApplicationRecord
  belongs_to :size
  belongs_to :user
  belongs_to :variant

  validates_presence_of :quantity

  def price_sell
    variant.price_sell * quantity
  end

  def available
    variant.availabilities.active.where(size: size).sum(&:quantity)
  end

  def available?
    available >= quantity
  end
end
