class Size < ApplicationRecord
  has_many :availabilities, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :nullify
end
