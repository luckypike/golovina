FactoryBot.define do
  factory :delivery_city do
    sequence(:title) { |n| "City #{n}" }
    door { 100 }
    door_days { '3-4' }
    storage { 80 }
    storage_days { '3-4' }
  end
end
