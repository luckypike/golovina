class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :variant
  belongs_to :size
  belongs_to :refund, optional: true
  has_many :acts, dependent: :nullify

  validates :quantity, presence: true

  def price_sell
    variant.price_sell * quantity
  end

  def available
    variant.availabilities.active.where(size: size).sum(&:quantity)
  end

  def available_to_preorder
    variant.preorder - variant.preordered
  end

  def available?
    (available + available_to_preorder) >= quantity
  end

  def process_acts
    availability = Availability.find_by(variant: variant, size: size)
    return unless availability

    unallocated_quantity = quantity

    Store.find_each do |store|
      store_quantity = availability.acts.where(store: store).sum(:quantity)

      allocated_quantity = [unallocated_quantity, store_quantity].min

      act = acts.build(
        state: :paid,
        availability: availability,
        store: store,
        quantity: allocated_quantity * -1
      )

      unallocated_quantity -= allocated_quantity if act.save

      break if unallocated_quantity.zero?
    end

    variant.reload

    return unless unallocated_quantity.positive? && available_to_preorder.positive?

    allocated_quantity = [unallocated_quantity, available_to_preorder].min

    acts.create(
      state: :preorder,
      availability: availability,
      store: Store.factory,
      quantity: allocated_quantity
    )

    acts.create(
      state: :paid,
      availability: availability,
      store: Store.factory,
      quantity: allocated_quantity * -1
    )

    unallocated_quantity -= allocated_quantity

    return if unallocated_quantity.zero?

    Bugsnag.notify(
      {
        order_id: order_id,
        order_item_id: id,
        unallocated_quantity: unallocated_quantity
      }
    )
  end

  class << self
    def with_variant
      includes(
        variant: [
          :images,
          :translations,
          :availabilities,
          :color,
          product: %i[translations category]
        ]
      )
    end

    def with_size
      includes(
        :size
      )
    end
  end
end
