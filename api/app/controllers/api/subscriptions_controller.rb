# frozen_string_literal: true

module Api
  class SubscriptionsController < Api::ApplicationController
    def create
      skip_authorization

      Subscriptions::CreateCmd.call(subscription_params: params)
    end
  end
end
