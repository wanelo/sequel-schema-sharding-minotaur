module Reporter
  class Data
    def to_a
      futures = []
      Reporter.redis do |redis|
        timestamps = redis.keys '*'
        redis.pipelined do
          timestamps.map do |t|
            futures << redis.lrange(t, 0, -1)
            redis.del t
          end
        end
      end
      futures.map(&:value).flatten.map(&:to_i)
    end
  end
end
