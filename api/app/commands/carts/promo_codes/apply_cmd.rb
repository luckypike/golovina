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
        validate_single_use!(promo_code, user)
        order.update(promo_code: promo_code)
      end

      private

      def find_promo_code(title)
        PromoCode.state_active.find_by!(title: title)
      end

      def validate_single_use!(promo_code, user)
        return unless promo_code.single_use_per_user? && Api::Order
          .where(state: %i[paid archived], user: user, promo_code: promo_code).any?

        fail!(
          errors: { promo_code_id: I18n.t("contracts.errors.order.promo_code_used?") },
          http_status_code: :unprocessable_entity
        )
      end
    end
  end
end
