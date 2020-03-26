class Order < ApplicationRecord
  PROMO = 0
  GIFT = 150

  enum delivery_option: { door: 1, storage: 2 }
  enum delivery: { pickup: 1, russia: 2, international: 3 }

  enum state: { undef: 0, active: 1, paid: 2, archived: 3 } do
    event :activate do
      after do
        user.activate(user.email, type: :order) if user.guest?
        user.update(phone: phone)
        OrderMailer.activate(self).deliver if Rails.env.development?
      end

      transition undef: :active
    end

    event :pay do
      after do
        if Rails.env.production?
          Sms.message(phone, sms_message)
          OrderMailer.sms_doubling(self, user.email).deliver_later
        else
          OrderMailer.sms_test(self).deliver_later
        end

        OrderMailer.pay(self).deliver_later

        order_items.each do |item|
          item.update(price: item.variant.price_sell)
          item.variant.decrease item
        end

        update(payed_at: Time.current)
      end

      transition active: :paid
    end

    event :archive do
      transition paid: :archived
    end
  end

  belongs_to :user, default: -> { Current.user }
  accepts_nested_attributes_for :user, update_only: true

  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  belongs_to :delivery_city, optional: true

  validates :delivery, presence: true
  validate :quantity_cannot_be_greater_than_total, on: :create
  validates :address, presence: true, if: -> { (russia? && door?) || international? }
  validates :delivery_city, presence: true, if: -> { russia? }
  validates :delivery_option, presence: true, if: -> { russia? }

  validates :phone, presence: true

  before_validation :clear_phone

  include ActionView::Helpers::NumberHelper
  include ProductsHelper
  include OrdersHelper

  def number
    id
  end

  def promo?
    !promo.nil? && amount_without_delivery >= promo
  end

  def gift?
    !gift.nil?
  end

  def amount
    if promo?
      @amount ||= order_items.map(&:price_sell).sum + (international? ? 2500 : 0) + (gift? ? GIFT : 0)
    else
      @amount ||= order_items.map(&:price_sell).sum + (international? ? 2500 : (russia? ? delivery_city.send(delivery_option) : 0)) + (gift? ? GIFT : 0)
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


  def clear_phone
    self.phone = phone&.gsub(/[\D]/, '')
  end

  def purchasable?
    active? && order_items.reject(&:available?).size == 0 && amount > 0 && user == Current.user
  end

  def sms_message
    if I18n.locale == :ru
      "Заказ #{self.number} (#{number_to_rub(self.amount).gsub('&nbsp;', ' ')}) оплачен. Ожидайте, пожалуйста, звонка."
    else
      "Hello! Thank you for your order № #{self.number} (#{number_to_rub(self.amount).gsub('&nbsp;', ' ')}). It has been paid successfully. We will contact you by E-mail."
    end
  end

  def quantity_cannot_be_greater_than_total
    order_items.includes(variant: :availabilities).each do |order_item|
      unless order_item.available?
        errors.add(:order_items)
      end
    end
  end
end
