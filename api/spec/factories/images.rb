# frozen_string_literal: true

FactoryBot.define do
  factory :image, class: Api::Image do
    uuid { SecureRandom.uuid }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/IMG_0446.jpeg'), 'image/png') }
  end
end
