class Order < ApplicationRecord
  enum state: { undef: 0, active: 1, paid: 2, archived: 3, declined: 4 } do
    event :activate do
      after do
        # OrderMailer.activate(self).deliver_later
      end

      transition :undef => :active
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

      transition :active => :paid
    end

    event :archive do
      transition :paid => :archived
    end

    event :decline do
      transition :active => :declined
    end
  end

  belongs_to :user

  has_many :order_items, dependent: :destroy

  include ActionView::Helpers::NumberHelper
  include ProductsHelper
  include OrdersHelper


  # accepts_nested_attributes_for :user

  def number
    self.id
  end

  def amount
    @amount ||= order_items.map(&:item_price).sum
  end

  def can_paid?
    amount > 0 && active?
  end

  def purchasable
    self.order_items.all?{|item| item.variant.purchasable(item.size, item.quantity)} ? true : false
  end

  def sms_message
    "Заказ #{self.number} (#{number_to_rub(self.amount).gsub('&nbsp;', ' ')}) оплачен. Ожидайте, пожалуйста, звонка."
  end
end
