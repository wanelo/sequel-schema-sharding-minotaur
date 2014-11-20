require 'simple_config'

module ShardMonitor
  class Config < SimpleConfig
    option :redis,
      :short => '-u REDIS_URI',
      :long  => '--redis REDIS_URI',
      :description => 'URI with which to connect to redis, eg: redis://1.1.1.1/1',
      :default => 'redis://127.0.0.1/1'

    option :table_name,
      :short => '-t TABLE',
      :long  => '--table TABLE',
      :description => 'Name of table used by a sequel-schema-sharding model',
      :required => true
  end
end
