# frozen_string_literal: true

module RedisSidekiqConnection
  def self.redis_instance
    Redis.new(config_options)
  end

  def self.config_options
    if ENV['REDIS_URL'].present?
      { url: ENV['REDIS_URL'] }.merge(connection_options)
    elsif Rails.env.test?
      { url: 'redis://127.0.0.1:6380' }.merge(connection_options)
    else
      { url: 'redis://127.0.0.1:6382' }.merge(connection_options)
    end
  end

  ##
  # The connect, read, and write timeout is configured for 5 seconds (all set by timeout).
  # Will make 3 reconnect attempts exponentially increasing the duration between each attempt.
  # The attempts look like this:
  #
  #  Retry    Attempt wait time
  #  1            0.5 sec
  #  2            1.0 sec
  #  3            2.0 sec
  #
  def self.connection_options
    { timeout: 5, reconnect_attempts: 3, reconnect_delay: 0.5,
      ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
  end
end
