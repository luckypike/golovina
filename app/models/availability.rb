class Availability < ApplicationRecord
  belongs_to :variant
  belongs_to :size
  belongs_to :store

  after_save :check_variant

  scope :active, -> { where.not(quantity: 0) }

  def active?
    quantity && quantity > 0
  end

  def check_variant
    if variant.availabilities.size < 1
      variant.archived!
    else
      variant.active!
    end
  end
end
