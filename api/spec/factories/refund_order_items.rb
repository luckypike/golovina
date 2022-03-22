# frozen_string_literal: true

FactoryBot.define do
  factory :refund_order_item, class: "Api::RefundOrderItem" do
    association :order_item, factory: :api_order_item
    refund
  end
end
