class Order < ApplicationRecord
  PROMO = 0
  GIFT = 300

  attr_accessor :to_pay

  enum delivery_option: { door: 1, storage: 2 }
  enum delivery: { pickup: 1, russia: 2, international: 3 }

  enum state: { cart: 0, paid: 2, archived: 3 } do
    event :pay do
      after do
        order_items.each do |item|
          item.update(amount: item.variant.price_sell)
          item.process_acts
        end

        update(
          amount: amount_calc,
          amount_delivery: amount_delivery_calc,
          payed_at: Time.current
        )

        save_address

        OrderMailer.pay(self).deliver_later
        OrderMailer.customer_notice(self, user.email).deliver_later
      end

      transition cart: :paid
    end

    event :archive do
      transition paid: :archived
    end
  end

  belongs_to :user, default: -> { Current.user }
  accepts_nested_attributes_for :user, update_only: true

  has_many :order_items, dependent: :destroy
  alias_attribute :items, :order_items
  # accepts_nested_attributes_for :order_items

  belongs_to :user_address, optional: true
  belongs_to :delivery_city, optional: true

  validates :street, :house, :appartment, presence: true, if: -> { (russia? && door?) || international? }
  validates :delivery_city, :delivery_option, presence: true, if: -> { russia? }
  validates :country, :city, presence: true, if: -> { international? }

  validates :delivery, presence: true, if: :to_pay

  include ActionView::Helpers::NumberHelper
  include ProductsHelper
  include OrdersHelper

  def number
    id
  end

  # def gift?
  #   !gift.nil?
  # end

  def amount_calc
    amount_without_delivery_calc +
      (international? && amount_without_delivery_calc < 30_000 ? amount_delivery_calc : 0)
  end

  def amount_delivery_calc
    if international?
      2500
    elsif russia?
      delivery_city.send(delivery_option)
    else
      0
    end
  end

  def amount_without_delivery_calc
    order_items.map(&:price_sell).sum
  end

  def quantity
    order_items.sum(&:quantity)
  end

  def month
    payed_at.beginning_of_month
  end

  def purchasable?
    cart? && order_items.reject(&:available?).size.zero? && amount_calc.positive?
  end

  def quantity_cannot_be_greater_than_total
    order_items.includes(variant: :availabilities).each do |order_item|
      unless order_item.available?
        errors.add(:order_items)
      end
    end
  end

  def save_address
    if (russia? && door?) || international?
      current_user_address = user_address
      current_user_address ||= build_user_address
      current_user_address.assign_attributes({
        delivery_option: delivery_option,
        delivery_city: delivery_city,
        user: user,
        country: country,
        city: city,
        street: street,
        house: house,
        appartment: appartment
      })

      current_user_address.save!
    end
  end

  class << self
    def with_items
      includes(
        { order_items: [{
          variant: [
            :images,
            :translations,
            :availabilities,
            color: :translations,
            product: %i[translations category]
          ]
        }, :size] }, :delivery_city
      )
    end

    def for_amount
      includes(order_items: :variant)
    end
  end
end
