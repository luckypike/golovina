class Kit < ApplicationRecord
  has_many :kitables
  has_many :products, through: :kitables
end
