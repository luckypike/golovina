class Order < ApplicationRecord
  enum state: { undef: 0, active: 1, paid: 2, archived: 3, declined: 4 } do
    event :activate do
      after do
        user.common!
        # OrderMailer.activate(self).deliver_later
      end

      transition undef: :active
    end

    event :pay do
      after do
        if Rails.env.production?
          Sms.message(user.phone, sms_message)
        else
          OrderMailer.sms_test(self).deliver_later
        end

        OrderMailer.pay(self).deliver_later

        self.order_items.each do |item|
          item.variant.sizes[item.size.to_s] = item.variant.sizes[item.size.to_s].to_i - item.quantity
          item.variant.save
        end
      end

      transition active: :paid
    end

    event :archive do
      transition :paid => :archived
    end

    event :decline do
      transition :active => :declined
    end
  end

  belongs_to :user, default: -> { Current.user }
  accepts_nested_attributes_for :user, update_only: true

  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates_presence_of :address
  validate :quantity_cannot_be_greater_than_total

  include ActionView::Helpers::NumberHelper
  include ProductsHelper
  include OrdersHelper

  def number
    self.id
  end

  def amount
    @amount ||= order_items.map(&:price_sell).sum
  end

  def quantity
    order_items.sum(&:quantity)
  end

  # def can_paid?
  #   amount > 0 && active?
  # end
  #
  def purchasable?
    active? && order_items.reject(&:available?).size == 0 && amount > 0
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
