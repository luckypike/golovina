# frozen_string_literal: true

namespace :migrate do
  namespace :users do
    desc "Normalize phones"
    task phones: :environment do
      Api::User.where.not(phone: nil).each do |user|
        temp_phone = user.phone.squish
        temp_phone = "+#{temp_phone[2..]}" if temp_phone.start_with?("00")
        temp_phone = "+7#{temp_phone}" if temp_phone.start_with?("(9")
        temp_phone = temp_phone.gsub(/[^\d]/, "")
        temp_phone = "7#{temp_phone}" if temp_phone.start_with?("9") && temp_phone.size == 10
        temp_phone = "+#{temp_phone}" unless temp_phone.start_with?("+")
        temp_phone[1] = "7" if temp_phone.size == 12 && temp_phone[1] == "8"
        if temp_phone.size < 12 || temp_phone.size > 16
          user.update(phone: nil)
        else
          user.update(phone: temp_phone)
        end

      end
    end
  end
end
