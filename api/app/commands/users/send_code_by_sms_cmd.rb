# frozen_string_literal: true

module Users
  class SendCodeBySmsCmd < ApplicationCmd
    input :user

    def call
      SmsaeroClient.sms_send_code(user.phone, user.phone_code)
    end
  end
end
