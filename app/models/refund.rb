class Refund < ApplicationRecord
  enum state: { active: 1, done: 2 } do
    event :do do
      after do
        order_items.each do |item|
          item.repayment = true
          item.save
        end
      end

      transition active: :done
    end
  end

  enum reason: { sizes: 1, defect: 2, color: 3, other: 0 }

  has_many :order_items
  accepts_nested_attributes_for :order_items

  belongs_to :user, default: -> { Current.user }
  belongs_to :order

  def quantity
    order_items.sum(&:quantity)
  end

  def amount
    @amount ||= order_items.map(&:price_sell).sum
  end
end
