FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@golovina.store" }
    sequence(:name) { |n| "user#{n}" }
    password { '12345678' }
    sequence(:phone) { |n| 79999999999 - n }
  end
end
