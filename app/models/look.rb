class Look < ApplicationRecord
  has_many :lookables

  has_many :products, through: :lookables, source: :lookable, source_type: 'Product'
  has_many :kits, through: :lookables, source: :lookable, source_type: 'Kit'
end
