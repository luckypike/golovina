# frozen_string_literal: true

module Carts
  class VerifyCmd < ApplicationCmd
    input :order
    input :verify_params
    output :user

    def call
      params = validate_contract!(VerifyContract, verify_params)
      user = Api::User.find_by!(phone: params[:phone], phone_code: params[:code])
      merge_users(order, user)
      self.user = user
    end

    private

    def merge_users(order, user) # rubocop:disable Metrics/AbcSize
      order.transaction do
        order.lock!
        order.user.lock!
        user.lock!

        # Remove carts from target user
        user.orders.state_cart.destroy_all

        # Move current identities to target user
        order.user.identities.find_each { |identity| identity.update(user_id: user.id) }

        # Move wishlists to target user
        user.wishlists.find_each { |wishlist| wishlist.update(user_id: user.id) }

        # Move current order to target user
        order.update(user_id: user.id)

        # For safety??
        user.update(state: :active, phone_code: nil)
      end
    end
  end
end
