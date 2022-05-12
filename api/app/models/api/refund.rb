# frozen_string_literal: true

module Api
  class Refund < ApplicationRecord
    enum reason: { size: 1, defect: 2, color: 3, other: 0 }, _prefix: true
    enum state: { active: 1, archived: 2 }, _prefix: true do
      event :archive do
        transition active: :archived
      end
    end

    belongs_to :user
    belongs_to :order
    has_many :refund_order_items, dependent: :destroy

    validates :state, presence: true

    # TODO: check month and day methods
    def month
      order.payed_at.beginning_of_month
    end

    def day
      order.payed_at.beginning_of_day
    end

    def amount
      @amount ||= refund_order_items.sum(&:amount)
    end
  end
end
