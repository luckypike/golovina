class Order < ApplicationRecord
  PROMO = 0
  GIFT = 300

  attr_accessor :to_pay

  enum delivery_option: { door: 1, storage: 2 }
  enum delivery: { pickup: 1, russia: 2, international: 3 }

  enum state: { cart: 0, paid: 2, archived: 3 } do
    # event :activate do
    #   after do
    #     user.activate(user.email, type: :order) if user.guest?
    #     user.update(phone: phone)
    #     OrderMailer.activate(self).deliver if Rails.env.development?
    #   end
    #
    #   transition undef: :active
    # end
    #
    # event :pay do
    #   after do
    #     OrderMailer.pay(self).deliver_later
    #     OrderMailer.customer_notice(self, user.email).deliver_later
    #
    #     order_items.each do |item|
    #       item.update(price: item.variant.price_sell)
    #       item.variant.decrease item
    #     end
    #
    #     update(payed_at: Time.current)
    #   end
    #
    #   transition active: :paid
    # end
    #
    # event :archive do
    #   transition paid: :archived
    # end
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

  def address
    address_old.present? ? address_old : "#{street} #{house}-#{appartment}"
  end

  def promo?
    !promo.nil? && amount_without_delivery >= promo
  end

  def gift?
    !gift.nil?
  end

  def amount
    if promo?
      @amount ||= order_items.map(&:price_sell).sum + (international? ? (amount_without_delivery > 30000 ? 0 : 2500) : 0) + (gift? ? GIFT : 0)
    else
      @amount ||= order_items.map(&:price_sell).sum + (international? ? (amount_without_delivery > 30000 ? 0 : 2500) : (russia? ? delivery_city.send(delivery_option) : 0)) + (gift? ? GIFT : 0)
    end
  end

  def amount_without_delivery
    order_items.map(&:price_sell).sum
  end

  def quantity
    order_items.sum(&:quantity)
  end

  def month
    (payed_at.presence || created_at).beginning_of_month
  end


  def purchasable?
    active? && order_items.reject(&:available?).size == 0 && amount > 0 && user == Current.user
  end

  def quantity_cannot_be_greater_than_total
    order_items.includes(variant: :availabilities).each do |order_item|
      unless order_item.available?
        errors.add(:order_items)
      end
    end
  end
end
