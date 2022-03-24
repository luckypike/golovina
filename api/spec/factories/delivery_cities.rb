# frozen_string_literal: true

FactoryBot.define do
  factory :delivery_city do
    title { Faker::Address.city }
    door { 100 }
    door_days { "3-4" }
    storage { 80 }
    storage_days { "3-4" }
  end
end
