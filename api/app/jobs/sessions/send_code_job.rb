# frozen_string_literal: true

module Sessions
  class SendCodeJob < ApplicationJob
    queue_as :default

    def perform(user:)
      Users::SendCodeBySmsCmd.call(user: user)
    end
  end
end
