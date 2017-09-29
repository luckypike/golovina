class Order < ApplicationRecord
  enum state: { undef: 0, active: 1, archived: 2 }

  belongs_to :user

  has_many :order_items

  include ActionView::Helpers::NumberHelper
  include ProductsHelper
  include OrdersHelper


  # accepts_nested_attributes_for :user

  def number
    self.id
  end

  def amount
    order_items.map(&:price).sum
  end

  def sms_message
    "Заказ № #{self.number} на сумму #{number_to_rub(self.amount).gsub('&nbsp;', ' ')} принят. Мы позвоним для подтверждения."
  end
end
