# frozen_string_literal: true

FactoryBot.define do
  factory :identity, class: "Api::Identity" do
    provider { :apple }
    uid { SecureRandom.uuid }
  end
end
