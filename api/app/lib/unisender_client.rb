# frozen_string_literal: true

class UnisenderClient
  include Singleton

  attr_reader :client

  def initialize
    @client = Faraday.new('https://api.unisender.com', params: { api_key: Figaro.env.unisender_api_key! }) do |f|
      f.request :json
      f.response :json
    end
  end

  class << self
    delegate :client, to: :instance

    def subscribe(params)
      client.get('/ru/api/subscribe', **params)
    end
  end
end
