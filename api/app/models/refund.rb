# frozen_string_literal: true

class Refund < ApplicationRecord
  enum state: { active: 1, archived: 2 }
  enum reason: { sizes: 1, defect: 2, color: 3, other: 0 }

  has_many :refund_order_items, dependent: :destroy, class_name: "Api::RefundOrderItem"
  has_many :order_items, through: :refund_order_items

  belongs_to :user, default: -> { Current.user }
  belongs_to :order

  def quantity
    order_items.sum(&:quantity)
  end

  def amount
    @amount ||= order_items.sum(&:price_final)
  end

  def month
    order.payed_at.beginning_of_month
  end

  def day
    order.payed_at.beginning_of_day
  end

  class << self
    def with_items
      includes(
        { order_items: [{
          variant: [
            :images,
            :translations,
            color: :translations
          ]
        }, :size] }
      )
    end
  end
end
