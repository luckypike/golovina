# frozen_string_literal: true

FactoryBot.define do
  factory :api_order, class: "Api::Order" do
    state { :paid }
    user

    trait :cart do
      state { :cart }
    end
  end
end
