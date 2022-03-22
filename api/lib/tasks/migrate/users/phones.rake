# frozen_string_literal: true

# rubocop:disable all

namespace :migrate do
  namespace :users do
    desc "Normalize phones"
    task phones: :environment do
      Api::User.find(3).state_active!

      Api::User.state_guest.where(last_sign_in_at: nil)
        .or(Api::User.state_guest.where("last_sign_in_at < ?", 6.months.ago)).each do |user|
          user.orders.state_cart.destroy_all
          user.destroy
        end

      Api::User.where.not(phone_legacy: nil).each do |user|
        temp_phone = user.phone_legacy.squish
        temp_phone = "+#{temp_phone[2..]}" if temp_phone.start_with?("00")
        temp_phone = "+44#{temp_phone[1..]}" if temp_phone.start_with?("0")
        temp_phone = "+7#{temp_phone}" if temp_phone.start_with?("(9")
        temp_phone = temp_phone.gsub(/[^\d]/, "")
        temp_phone = "7#{temp_phone}" if temp_phone.start_with?("9") && temp_phone.size == 10
        temp_phone = "+#{temp_phone}" unless temp_phone.start_with?("+")
        temp_phone[1] = "7" if temp_phone.size == 12 && temp_phone[1] == "8"

        if temp_phone.size < 12 || temp_phone.size > 16
          user.assign_attributes({ phone: nil })
        else
          user.assign_attributes({ phone: temp_phone })
        end

        user.save(validate: false)
      end

      Api::User.where.not(phone: nil).group_by(&:phone).select { |_, users| users.size > 1 }.each do |phone, users|
        users.each do |user|
          # Remove carts for users without archived or paid orders
          user.orders.state_cart.destroy_all if user.orders.where(state: %i[paid archived]).none?

          # user.orders.state_cart.destroy_all
        end

        active_users = users.select { |user| user.orders.any? }

        if active_users.size == 1
          active_user = active_users.first

          users.each do |user|
            user.identities.each do |identity|
              identity.update(user_id: active_user.id)
            end

            next if active_user.id == user.id

            UserAddress.where(user_id: user.id).update(user_id: active_user.id)
            user.destroy
          end
        else
          active_user =
            if active_users.size.zero?
              users.reject do |user|
                user.email.end_with?("golovinamari.com", "privaterelay.appleid.com")
              end.max_by(&:last_sign_in_at)
            else
              active_users.reject do |user|
                user.email.end_with?("golovinamari.com", "privaterelay.appleid.com")
              end.max_by(&:last_sign_in_at)
            end

          active_user ||=
            if active_users.size.zero?
              users.max_by(&:last_sign_in_at)
            else
              active_users.max_by(&:last_sign_in_at)
            end

          users.each do |user|
            user.identities.each do |identity|
              identity.update(user_id: active_user.id)
            end

            next if active_user.id == user.id

            Api::Order.where(state: %i[paid archived]).where(user_id: user.id).update(user_id: active_user.id)
            Api::Order.where(state: %i[cart]).where(user_id: user.id).destroy_all
            Api::Refund.where(user_id: user.id).update(user_id: active_user.id)
            Wishlist.where(user_id: user.id).update(user_id: active_user.id)
            UserAddress.where(user_id: user.id).update(user_id: active_user.id)
            user.destroy
          end
        end

        print "."
      end

      puts ""
    end
  end
end

def guest_email?(email)
  email.match(/guest_.*?@golovina\.store/i) || email.match(/guest_.*?@golovinamari\.com/i)
end

def relay_email?(email)
  email.match(/.+?@privaterelay\.appleid\.com/i)
end

# rubocop:enable
