class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :variant

  validates_presence_of :quantity, :size
end
