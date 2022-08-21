# frozen_string_literal: true

module Refunds
  class IndexCmd < ApplicationCmd
    input :user
    output :orders
    output :refunded_order_items

    def call
      self.orders = Api::Order
        .includes(order_items: [:size, { variant: %i[translations color] }])
        .where(user: user, state: %i[paid archived]).order(payed_at: :desc)

      self.refunded_order_items = Api::RefundOrderItem.where(
        order_item: orders.map { |order| order.order_items.map(&:id) }.flatten
      ).pluck(:order_item_id)
    end
  end
end
