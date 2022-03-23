# frozen_string_literal: true

FactoryBot.define do
  factory :api_user, class: "Api::User" do
    email { Faker::Internet.email }
    state { :active }

    trait :apple_id do
      email { "123456@privaterelay.appleid.com" }
      phone { nil }
    end

    trait :guest do
      state { :guest }
      email { "guest_123456@golovinamari.com" }
      phone { nil }
    end
  end
end
