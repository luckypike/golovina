FactoryBot.define do
  factory :product do
    sequence(:title) { |n| "product#{n}" }
    category
  end
end
