# frozen_string_literal: true

module Api
  class Order < ApplicationRecord
    enum state: { cart: 0, paid: 2, archived: 3 }, _prefix: true
    enum delivery: { pickup: 1, russia: 2, international: 3 }, _prefix: true
    enum delivery_option: { door: 1, storage: 2 }, _prefix: true

    has_many :order_items, dependent: :destroy
    belongs_to :user
    belongs_to :delivery_city, optional: true
    belongs_to :promo_code, optional: true

    def price
      order_items.joins(:variant).where(variants: { state: :active }).sum(&:price)
    end

    def price_final
      temp = order_items.joins(:variant).where(variants: { state: :active }).sum(&:price_final)
      temp = promo_code.apply(temp) if promo_code
      temp
    end

    def price_delivery
      if delivery_international?
        2_800
      elsif delivery_russia?
        return delivery_city[delivery_option] if delivery_city && delivery_option
      else
        0
      end
    end

    def paid_at
      payed_at
    end
  end
end
