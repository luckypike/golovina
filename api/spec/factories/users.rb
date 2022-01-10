# frozen_string_literal: true

# TODO: remove guest_user and common_user

FactoryBot.define do
  factory :user, aliases: [:common_user] do
    email { Faker::Internet.email }
    password { '123456' }
    name { Faker::Name.first_name }
    sname { Faker::Name.last_name }
    phone { Faker::PhoneNumber.cell_phone_with_country_code }
    state { :common }

    trait :editor do
      editor { true }
    end

    factory :guest_user do
      email { User.guest_email }
      state { :guest }
    end
  end
end
