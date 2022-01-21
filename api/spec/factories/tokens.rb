# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    key { :service }
    value { Random.hex }
  end
end
