class Availability < ApplicationRecord
  belongs_to :variant
  belongs_to :size
  belongs_to :store

  scope :active, -> { where.not(quantity: 0) }

  def active?
    quantity > 0
  end
end
