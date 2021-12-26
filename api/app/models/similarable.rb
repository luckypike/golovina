class Similarable < ApplicationRecord
  belongs_to :product
  belongs_to :similar_product, class_name: 'Product'
end
