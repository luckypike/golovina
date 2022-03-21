# frozen_string_literal: true

FactoryBot.define do
  factory :refund, class: "Api::Refund" do
    association :order, factory: :api_order
    state { :active }
    reason { :other }
    detail { "MyText" }
  end
end
