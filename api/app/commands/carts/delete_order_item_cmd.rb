# frozen_string_literal: true

module Carts
  class DeleteOrderItemCmd < ApplicationCmd
    input :order_item

    def call
      order_item.transaction do
        order_item.lock!

        if order_item.quantity > 1
          order_item.decrement(:quantity, 1)
          order_item.save!
        else
          order_item.destroy
        end
      end
    end
  end
end
