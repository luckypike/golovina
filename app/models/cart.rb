class Cart < ApplicationRecord
  belongs_to :size
  belongs_to :user
  belongs_to :variant

  validates_presence_of :quantity
end
