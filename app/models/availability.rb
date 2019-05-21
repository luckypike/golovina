class Availability < ApplicationRecord
  belongs_to :variant
  belongs_to :size
  belongs_to :store

  after_save :check_variant

  after_initialize do
    self.quantity = quantity.to_i
  end

  scope :active, -> { where.not(quantity: 0) }
  scope :inactive, -> { where(quantity: [0, nil]) }

  def check_variant
    variant.check_state
  end

  def active?
    quantity && quantity > 0
  end
end
