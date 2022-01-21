# frozen_string_literal: true

module Tokens
  class IgUpdateJob < ApplicationJob
    queue_as :default

    def perform
      Token.where(key: :instagram).where('expires_at < ?', Time.current).each do |token|
        Tokens::IgUpdateCmd.call(token: token)
      end
    end
  end
end
