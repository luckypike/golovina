# frozen_string_literal: true

FactoryBot.define do
  factory :category, class: "Api::Category" do
    sequence(:title) { |n| "category#{n}" }
    sequence(:slug) { |n| "slug-#{n}" }
  end
end
