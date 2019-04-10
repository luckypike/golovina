require 'net/http'
require 'addressable/uri'

class Sms
  def self.message phone, message
    Net::HTTP.get(Addressable::URI.parse("https://gate.smsaero.ru/send/?user=#{Rails.application.credentials[:sms][:login]}&password=#{Rails.application.credentials[:sms][:password]}&to=#{phone}&text=#{message}&from=mint-store"))
  end
end
