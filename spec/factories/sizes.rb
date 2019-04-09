FactoryBot.define do
  factory :size do
    sequence(:size) { |n| "size#{n}" }
  end
end
