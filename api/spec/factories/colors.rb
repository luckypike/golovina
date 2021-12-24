FactoryBot.define do
  factory :color do
    sequence(:title) { |n| "color#{n}" }
  end
end
