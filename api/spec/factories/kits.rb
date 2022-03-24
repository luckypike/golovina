# frozen_string_literal: true

FactoryBot.define do
  factory :kit, class: "Api::Kit" do
    title_ru { Faker::Commerce.product_name }
    category
    state { :active }
  end
end
