# frozen_string_literal: true

class SubscriptionProcessJob < ApplicationJob
  queue_as :default

  def perform(subscription:)
    Subscriptions::ProcessCmd.call(subscription: subscription)
  end
end
