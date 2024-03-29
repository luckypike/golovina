# frozen_string_literal: true

class Order < ApplicationRecord
  PROMO = 0
  GIFT = 300

  attr_accessor :to_pay

  enum delivery_option: { door: 1, storage: 2 }
  enum delivery: { pickup: 1, russia: 2, international: 3 }
  enum tracker_type: { cdek: 1, ems: 2, ups: 3 }

  enum state: { cart: 0, paid: 2, archived: 3 } do
    event :pay do
      before do
        self.amount = amount_calc
        self.amount_delivery = amount_delivery_calc
        self.payed_at = Time.current

        order_items.each do |item|
          temp = item.variant.price_sell
          temp = promo_code.apply(temp) if promo_code
          item.update(amount: temp)
          item.process_acts
        end
      end

      after do
        save_address

        OrderMailer.pay(self).deliver_later
        OrderMailer.with(order: self).payed.deliver_later
      end

      transition cart: :paid
    end

    event :archive do
      transition paid: :archived
    end

    event :unarchive do
      transition archived: :paid
    end
  end

  belongs_to :user, default: -> { Current.user }
  accepts_nested_attributes_for :user, update_only: true

  has_many :order_items, dependent: :destroy
  alias_attribute :items, :order_items
  # accepts_nested_attributes_for :order_items

  belongs_to :user_address, optional: true
  belongs_to :delivery_city, optional: true
  belongs_to :promo_code, optional: true

  validates :street, :house, :appartment, presence: true, if: -> { (russia? && door?) || international? }
  validates :delivery_city, :delivery_option, presence: true, if: -> { russia? }
  validates :country, :city, :zip, presence: true, if: -> { international? }

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
    temp = amount_without_delivery_calc + amount_delivery_calc
    temp = promo_code.apply(temp) if promo_code
    temp
  end

  def amount_delivery_calc
    if international?
      2_800
    elsif russia?
      # amount_without_delivery_calc < 15_000 ? delivery_city.send(delivery_option) : 0
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

  def day
    payed_at.beginning_of_day
  end

  def purchasable?
    cart? && order_items.reject(&:available?).size.zero? && amount_calc.positive?
  end

  def send_tracker
    OrderMailer.with(order: self).tracker.deliver_later
  end

  def tracker_url
    return unless tracker_id

    case tracker_type.to_sym
    when :ups
      "https://www.ups.com/ru/ru/SearchResults.page?q=#{tracker_id}"
    when :cdek
      "https://cdek.ru/tracking##{tracker_id}"
    when :ems
      "https://www.pochta.ru/tracking##{tracker_id}"
    end
  end

  def save_address
    if (russia? && door?) || international?
      current_user_address = user_address
      current_user_address ||= build_user_address
      current_user_address.assign_attributes(
        {
          delivery_option: delivery_option,
          delivery_city: delivery_city,
          user: user,
          zip: zip,
          country: country,
          city: city,
          street: street,
          house: house,
          appartment: appartment
        }
      )

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
            :color,
            product: %i[translations category]
          ]
        }, :size, { acts: :store }] }, :delivery_city
      )
    end

    def for_amount
      includes(order_items: :variant)
    end
  end
end
