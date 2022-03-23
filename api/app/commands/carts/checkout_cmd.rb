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
        validate_user!(user)
        user.save!
        order.save!
      end
    end

    private

    def validate_user!(user) # rubocop:disable Metrics/AbcSize
      return if user.valid?

      if user.errors.of_kind?(:phone, :taken)
        if user.errors.of_kind?(:email, :taken) && validate_email_and_phone_at_same_user?(user.email, user.phone)
          fail!(errors: {}, http_status_code: :forbidden)
        end
      elsif user.errors.of_kind?(:email, :taken) && temp_email?(user.email_was)
        fail!(errors: {}, http_status_code: :forbidden)
      end

      fail!(errors: user.errors.to_hash, http_status_code: :unprocessable_entity)
    end

    def validate_email_and_phone_at_same_user?(email, phone)
      Api::User.where(phone: phone, email: email).any?
    end

    def temp_email?(email)
      (
        email.start_with?("guest_") && email.end_with?("@golovinamari.com")
      ) || email.ends_with?("@privaterelay.appleid.com")
    end
  end
end
