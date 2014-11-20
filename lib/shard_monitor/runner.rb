require 'simple_runner'
require 'open3'

module ShardMonitor
  class Runner
    include SimpleRunner

    run do
      begin
        shards = stdout.read_nonblock(1024)
        ShardMonitor.redis do |redis|
          time = Time.now.to_i
          redis.rpush(time, shards.split("\n").map(&:to_i))
          redis.expire(time, 120)
        end
      rescue IO::WaitReadable
        IO.select([stdout])
        retry
      end
    end

    def stdout
      @stdout ||= begin
        stdin, stdout, _ = Open3.popen2(trace_command)
        stdin.close
        stdout
      end
    end

    def trace_command
      %Q(/usr/sbin/dtrace -q -n ':sequel_schema_sharding::shard_for / copyinstr(arg2) == "#{ShardMonitor.config.table_name}" / { printf("%d\\n", arg1) })
    end
  end
end
