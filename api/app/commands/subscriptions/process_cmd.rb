# frozen_string_literal: true

module Subscriptions
  class ProcessCmd < ApplicationCmd
    input :subscription

    def call
      subscription.update(state: :active)
    end
  end
end
