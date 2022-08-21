# frozen_string_literal: true

FactoryBot.define do
  factory :api_color, class: "Api::Color" do
    title_ru { Faker::Color.color_name }
    title_en { Faker::Color.color_name }
    color { Faker::Color.hex_color }

    trait :with_parent_color do
      parent_color factory: :api_color
    end

    trait :with_colors do
      after(:create) do |color|
        create_list(:api_color, 5, parent_color: color)
      end
    end
  end
end
