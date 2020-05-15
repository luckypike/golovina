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

  def available?
    available >= quantity
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
  end

  class << self
    def with_variant
      includes(
        variant: [
          :images,
          :translations,
          :availabilities,
          color: :translations,
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
