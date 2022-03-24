# frozen_string_literal: true

module Carts
  class ShowCmd < ApplicationCmd
    input :user
    output :order
    output :order_items

    def call
      self.order = user.orders.state_cart.first
      self.order_items = find_order_items(order)
    end

    private

    def find_order_items(order)
      return [] unless order

      order.order_items.joins(:variant)
        .includes(:size, variant: [:translations, { color: :translations }])
        .where(variants: { state: :active })
    end
  end
end