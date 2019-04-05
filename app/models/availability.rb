class Availability < ApplicationRecord
  belongs_to :variant
  belongs_to :size
  belongs_to :store

  scope :active, -> { where.not(count: 0) }

  def active?
    count > 0
  end
end
