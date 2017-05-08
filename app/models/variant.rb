class Variant < ApplicationRecord
  belongs_to :product
  belongs_to :color

  validates_uniqueness_of :color_id, scope: [:product_id]

end
