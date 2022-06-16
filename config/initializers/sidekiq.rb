Sidekiq.configure_server do |config|
  config.redis = RedisSidekiqConnection.config_options
end

Sidekiq.configure_client do |config|
  config.redis = RedisSidekiqConnection.config_options
end

Sidekiq.strict_args!
