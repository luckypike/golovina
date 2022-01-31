# frozen_string_literal: true

Bugsnag.configure do |config|
  config.api_key = '673aa0e9bec067aff31d11e3a6a71ea8'
  config.notify_release_stages = %w[production]
  config.app_version = Golovina::VERSION
end
