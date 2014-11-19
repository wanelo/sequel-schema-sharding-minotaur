require 'simple_config'

module Reporter
  class Config < SimpleConfig
    option :redis,
      :short => '-u REDIS_URI',
      :long  => '--redis REDIS_URI',
      :description => 'URI with which to connect to redis, (default redis://127.0.0.1/1)',
      :default => 'redis://127.0.0.1/1'

    option :circonus,
      :short => '-c CIRCONUS_URL',
      :long  => '--circonus CIRCONUS_URI',
      :description => 'Circonus HTTPTRAP URI',
      :required => true

    option :poll_interval,
      :short => '-i INTERVAL',
      :long  => '--poll-interval INTERVAL',
      :description => 'How often in seconds to check redis for metrics (default 60)',
      :default => 60,
      :proc => Proc.new { |i| i.to_i }

    option :debug,
      :short => '-d',
      :long => '--debug',
      :description => 'Enable debug logging',
      :default => false
  end
end
