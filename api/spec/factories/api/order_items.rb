# frozen_string_literal: true

FactoryBot.define do
  factory :api_order_item, class: "Api::OrderItem" do
    association :order, factory: :api_order
    variant
    size
  end
end
