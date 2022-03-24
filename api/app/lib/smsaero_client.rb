# frozen_string_literal: true

class SmsaeroClient
  include Singleton

  attr_reader :client

  def initialize
    @client = Faraday.new("https://gate.smsaero.ru") do |f|
      f.request :basic_auth, Figaro.env.smsaero_user!, Figaro.env.smsaero_password!
      f.request :json
      f.response :json
    end
  end

  class << self
    delegate :client, to: :instance

    def sms_send(params)
      params = params.merge({ sign: Figaro.env.smsaero_sign! })
      uri = "/v2/sms/send"
      uri = "/v2/sms/testsend" unless Rails.env.production?
      client.post(uri, params.to_json)
    end

    def sms_send_code(phone, code)
      sms_send(number: phone, text: "Golovina Mari: #{code}")
    end
  end
end
