require 'simple_config'

module ShardMonitor
  class Config < SimpleConfig
    option :redis,
      :short => '-u REDIS_URI',
      :long  => '--redis REDIS_URI',
      :description => 'URI with which to connect to redis, eg: redis://1.1.1.1/1',
      :default => 'redis://127.0.0.1/1'

    def redis
      config[:redis]
    end
  end
end
