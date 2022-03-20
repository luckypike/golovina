# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Golovina
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.time_zone = "Europe/Moscow"

    config.active_job.queue_adapter = :sidekiq
    config.active_storage.variant_processor = :vips
    config.cache_store = :redis_cache_store, {
      url: "redis://#{ENV.fetch('REDIS_HOST', :localhost)}:#{ENV.fetch('REDIS_PORT', 6379)}/#{ENV.fetch('REDIS_CACHE_DB', 1)}"
    }

    # TODO: Remove it
    config.action_dispatch.cookies_same_site_protection = nil

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators.system_tests = nil
    config.generators.jbuilder = nil
    config.generators.stylesheets = nil
    config.generators.javascripts = nil
    config.generators.test_framework = nil
    config.generators.helper = nil
  end
end
