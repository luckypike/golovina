# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    email { 'user@example.com' }
    first_name { 'Summer' }
    last_name { 'Beth' }
    date_of_birth { Time.current.to_date }
    state { :requested }
    locale { 'ru' }
  end
end
