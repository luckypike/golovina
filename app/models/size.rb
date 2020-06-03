class Size < ApplicationRecord
  default_scope { order(:weight) }

  has_many :availabilities, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :nullify

  def title
    size
  end
end
