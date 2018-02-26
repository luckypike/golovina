class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :variant

  def price
    variant.product.price_sell * quantity
  end
end
