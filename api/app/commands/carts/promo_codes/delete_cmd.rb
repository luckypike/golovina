# frozen_string_literal: true

module Carts
  module PromoCodes
    class DeleteCmd < ApplicationCmd
      input :user

      def call
        order = Api::Order.state_cart.find_by!(user: user)
        order.update(promo_code: nil)
      end
    end
  end
end
