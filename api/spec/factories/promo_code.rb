# frozen_string_literal: true

FactoryBot.define do
  factory :promo_code do
    title { "demo" }
    discount { :amount }
    value { 100 }
    state { :active }
    single_use_per_user { false }

    trait :percentage do
      discount { :percentage }
    end
  end
end
