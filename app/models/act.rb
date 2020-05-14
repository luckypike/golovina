class Act < ApplicationRecord
  belongs_to :availability
  belongs_to :store

  validates :quantity, presence: true

  after_save :availability_recalc

  def availability_recalc
    availability.update(quantity: availability.acts.sum(&:quantity))
    availability.variant.update(
      quantity: availability.variant.availabilities.sum(&:quantity),
      acts_count: availability.acts.size
    )
  end
end
