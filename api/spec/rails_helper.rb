# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

ENV["unisender_list_ru"] = "0"
ENV["unisender_list_en"] = "0"
ENV["unisender_api_key"] = SecureRandom.uuid

ENV["smsaero_user"] = "smsaero_user"
ENV["smsaero_sign"] = "smsaero_sign"
ENV["smsaero_password"] = "smsaero_password"

auth_private_key = OpenSSL::PKey::RSA.generate(2048)
ENV["AUTH_PRIVATE_KEY"] = auth_private_key.export
ENV["AUTH_PUBLIC_KEY"] = auth_private_key.public_key.export

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  # config.around do |example|
  #   Sequel::Model.db.transaction(rollback: :always, auto_savepoint: true) do
  #     example.run
  #   end
  # end

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
