class Act < ApplicationRecord
  enum state: { manual: 1, paid: 2, preorder: 3 }

  belongs_to :availability
  belongs_to :store
  belongs_to :order_item, optional: true

  validates :quantity, presence: true, numericality: { only_integer: true, other_than: 0 }

  after_save :availability_recalc

  def availability_recalc
    availability.update(quantity: availability.acts.reload.sum(&:quantity))

    variant = availability.variant
    variant.update(
      preordered: Act.preorder.where(availability: variant.availabilities).sum(:quantity),
      quantity: variant.availabilities.reload.sum(:quantity),
      acts_count: variant.acts.reload.size
    )
  end
end
