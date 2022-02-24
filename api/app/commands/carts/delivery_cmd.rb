# frozen_string_literal: true

module Carts
  class DeliveryCmd < ApplicationCmd
    input :order
    input :delivery_params

    def call
      params = validate_contract!(DeliveryContract, delivery_params)

      order.transaction do
        order.lock!
        order.assign_attributes(params)
        validate_entity!(order)
        order.save!
      end
    end
  end
end
