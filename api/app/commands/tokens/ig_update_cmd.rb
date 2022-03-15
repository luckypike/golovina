# frozen_string_literal: true

module Tokens
  class IgUpdateCmd < ApplicationCmd
    input :token

    def call
      uri = URI("https://graph.instagram.com/refresh_access_token?grant_type=ig_refresh_token&access_token=#{token.value}")
      res = Net::HTTP.get_response(uri)

      raise StandardError unless res.code == "200"

      new_token = JSON.parse(res.body).with_indifferent_access
      token.update(value: new_token[:access_token], expires_at: 60.days.from_now)
    end
  end
end
