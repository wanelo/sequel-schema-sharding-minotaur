require 'redis'
require 'reporter/config'
require 'reporter/runner'

module Reporter
  def self.config(argv = ARGV)
    @config ||= Reporter::Config.new.tap { |c| c.parse_options(argv) }
  end

  def self.redis
    @redis ||= Redis.new(url: config.redis)
    @redis.tap do |r|
      yield r if block_given?
    end
  end
end
