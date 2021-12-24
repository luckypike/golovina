FactoryBot.define do
  factory :store do
    sequence(:title) { |n| "store#{n}" }

    trait :default do
      id { 1 }
    end
  end
end
