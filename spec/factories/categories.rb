FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "category#{n}" }
    sequence(:slug) { |n| "slug-#{n}" }
  end
end
