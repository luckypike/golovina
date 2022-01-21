# frozen_string_literal: true

FactoryBot.define do
  factory :color do
    sequence(:title_ru) { |n| "Color #{n}" }
    sequence(:title_en) { |n| "Color #{n}" }
    color { Faker::Color.hex_color }
  end
end
