# frozen_string_literal: true

module Api
  class Order < ApplicationRecord
    enum state: { cart: 0, paid: 2, archived: 3 }, _prefix: true
    enum delivery: { pickup: 1, russia: 2, international: 3 }, _prefix: true
    enum delivery_option: { door: 1, storage: 2 }, _prefix: true

    has_many :order_items, dependent: :destroy
    belongs_to :user
    belongs_to :promo_code, optional: true

    def price
      order_items.joins(:variant).where(variants: { state: :active }).sum(&:price)
    end

    def price_final
      temp = order_items.joins(:variant).where(variants: { state: :active }).sum(&:price_final)
      temp = promo_code.apply(temp) if promo_code
      temp
    end
  end
end
