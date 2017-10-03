class Kitable < ApplicationRecord
  belongs_to :kit
  belongs_to :product, optional: true
  belongs_to :variant
end
