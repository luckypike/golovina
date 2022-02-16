# frozen_string_literal: true

module Subscriptions
  class ProcessCmd < ApplicationCmd
    input :subscription

    def call
      UnisenderClient.subscribe(
        fields: { email: subscription.email, Name: [subscription.first_name, subscription.last_name].join(' ') },
        double_optin: 3,
        list_ids: [Figaro.env.send("unisender_list_#{subscription.locale}!")]
      )

      subscription.update(state: :active)
    end
  end
end
