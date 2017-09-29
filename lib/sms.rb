require 'net/http'

class Sms
  def self.message phone, message
    Net::HTTP.get(URI.parse("https://gate.smsaero.ru/send/?user=#{Rails.application.secrets[:sms_login]}&password=#{Rails.application.secrets[:sms_password]}&to=#{phone}&text=#{message}&from=mint-store"))
  end
end