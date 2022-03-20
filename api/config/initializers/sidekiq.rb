# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = {
    host: ENV.fetch("REDIS_HOST", :localhost),
    port: ENV.fetch("REDIS_PORT", 6379),
    db: ENV.fetch("REDIS_DB", 0)
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    host: ENV.fetch("REDIS_HOST", :localhost),
    port: ENV.fetch("REDIS_PORT", 6379),
    db: ENV.fetch("REDIS_DB", 0)
  }
end
