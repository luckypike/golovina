# frozen_string_literal: true

FactoryBot.define do
  factory :availability do
    variant
    store
    size
    quantity { 1 }
  end
end
