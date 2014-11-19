require 'mixlib/cli'

module Reporter
  class Config
    include Mixlib::CLI

    option :redis,
      :short => '-u REDIS_URI',
      :long  => '--redis REDIS_URI',
      :description => 'URI with which to connect to redis, eg: redis://1.1.1.1/1',
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

    def circonus
      config[:circonus]
    end

    def redis
      config[:redis]
    end

    def poll_interval
      config[:poll_interval]
    end
  end
end
