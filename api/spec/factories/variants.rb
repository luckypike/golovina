# frozen_string_literal: true

FactoryBot.define do
  factory :variant, class: "Api::Variant" do
    product
    color factory: :api_color
    category
    title_ru { Faker::Commerce.product_name }
    state { :active }
  end
end
