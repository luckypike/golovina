# frozen_string_literal: true

module Subscriptions
  class CreateCmd < ApplicationCmd
    input :subscription_params

    def call
      params = validate_contract!(CreateContract, subscription_params)
      params[:locale] = I18n.locale
      params[:state] = :requested

      subscription = build_subscription(params.except(:confirm))
      validate_and_save_subscription(subscription)
      process_subscription(subscription)
    end

    private

    def build_subscription(params)
      Subscription.new(params)
    end

    def validate_and_save_subscription(subscription)
      validate_entity!(subscription)
      subscription.save!
    end

    def process_subscription(subscription)
      SubscriptionProcessJob.perform_later(subscription: subscription)
    end
  end
end
