# frozen_string_literal: true

FactoryBot.define do
  factory :size, class: "Api::Size" do
    sequence(:size) { |n| "Size #{n}" }
  end
end
