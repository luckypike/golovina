class Act < ApplicationRecord
  enum state: { manual: 1, paid: 2 }

  belongs_to :availability
  belongs_to :store
  belongs_to :order_item, optional: true

  validates :quantity, presence: true

  after_save :availability_recalc

  def availability_recalc
    availability.update(quantity: availability.acts.reload.sum(&:quantity))

    variant = availability.variant
    variant.update(
      quantity: variant.availabilities.reload.sum(&:quantity),
      acts_count: variant.acts.reload.size
    )
  end
end
