class Order < ApplicationRecord
  enum delivery_option: { door: 1, storage: 2 }
  enum delivery: { pickup: 1, russia: 2, international: 3 }

  enum state: { undef: 0, active: 1, paid: 2, archived: 3 } do
    event :activate do
      after do
        user.activate(user.email, type: :order) if user.guest?
        OrderMailer.activate(self).deliver if Rails.env.development?
      end

      transition undef: :active
    end

    event :pay do
      after do
        if Rails.env.production?
          Sms.message(user.phone, sms_message)
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

  include ActionView::Helpers::NumberHelper
  include ProductsHelper
  include OrdersHelper

  def number
    id
  end

  def amount
    @amount ||= order_items.map(&:price_sell).sum + (international? ? 2500 : (russia? ? delivery_city.send(delivery_option) : 0))
  end

  def quantity
    order_items.sum(&:quantity)
  end

  # def can_paid?
  #   amount > 0 && active?
  # end
  #
  def purchasable?
    active? && order_items.reject(&:available?).size == 0 && amount > 0 && user == Current.user
  end

  def sms_message
    "Заказ #{self.number} (#{number_to_rub(self.amount).gsub('&nbsp;', ' ')}) оплачен. Ожидайте, пожалуйста, звонка."
  end

  def quantity_cannot_be_greater_than_total
    order_items.includes(variant: :availabilities).each do |order_item|
      unless order_item.available?
        errors.add(:order_items)
      end
    end
  end
end
