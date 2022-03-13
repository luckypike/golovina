# frozen_string_literal: true

module Carts
  class CheckoutCmd < ApplicationCmd
    input :order
    input :checkout_params

    def call
      params = validate_contract!(CheckoutContract, checkout_params)
      user = order.user

      order.transaction do
        order.comment = params[:comment]
        user.assign_attributes(params.except(:comment))
        user.state = :active
        validate_entity!(user)
        user.save!
        order.save!
      end
    end
  end
end
