# frozen_string_literal: true

module Refunds
  class IndexCmd < ApplicationCmd
    input :user
    output :orders

    def call
      self.orders = Api::Order
        .includes(order_items: [:size, { variant: [:translations, { color: :translations }] }])
        .where(user: user, state: %i[paid archived]).order(payed_at: :desc)
    end
  end
end
