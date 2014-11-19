require 'redis'
require 'shard_monitor/config'
require 'shard_monitor/runner'

module ShardMonitor
  def self.config
    @config ||= ShardMonitor::Config.new.tap { |c| c.parse_options }
  end

  def self.redis
    @redis ||= Redis.new(url: config.redis)
    @redis.tap do |r|
      yield r if block_given?
    end
  end
end
