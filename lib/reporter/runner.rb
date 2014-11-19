require 'simple_runner'

module Reporter
  class Runner < SimpleRunner
    run do
      shards = nil
      Reporter.redis do |redis|
        timestamps = redis.keys '*'
        shards = []
        shards = redis.pipelined do
          timestamps.map do |t|
            redis.lrange t, 0, -1
            redis.del t
          end
        end
      end

      unless shards.empty?
        body = {
          'key' => {
            '_type' => 'n',
            '_value' => shards.flatten
          }
        }

        # Push to circonus
      end

      sleep Reporter.config.poll_interval
    end
  end
end
