# frozen_string_literal: true

FactoryBot.define do
  factory :api_user, class: 'Api::User' do
    email { Faker::Internet.email }
  end
end
