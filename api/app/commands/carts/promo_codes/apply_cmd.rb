# frozen_string_literal: true

module Carts
  module PromoCodes
    class ApplyCmd < ApplicationCmd
      input :user
      input :promo_code_params

      def call
        params = validate_contract!(ApplyContract, promo_code_params)
        order = Api::Order.state_cart.find_by!(user: user)
        promo_code = find_promo_code(params[:title].downcase)
        order.update(promo_code: promo_code)
      end

      private

      def find_promo_code(title)
        PromoCode.state_active.find_by!(title: title)
      end
    end
  end
end
