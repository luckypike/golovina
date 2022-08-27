# frozen_string_literal: true

module Carts
  class ShowCmd < ApplicationCmd
    input :user
    output :order
    output :order_items

    def call
      order = user.orders.state_cart.first
      remove_inactive_order_items(order)
      order_items = find_order_items(order)

      self.order = order
      self.order_items = order_items
    end

    private

    def find_order_items(order)
      return [] unless order

      order.order_items.joins(:variant)
        .includes(:size, variant: %i[translations color])
        .where(variants: { state: :active })
    end

    def remove_inactive_order_items(order)
      order.order_items.joins(:variant).where.not(variants: { state: :active }).destroy_all
    end
  end
end
