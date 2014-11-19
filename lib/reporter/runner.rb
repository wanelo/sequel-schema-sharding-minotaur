require 'net/http'
require 'reporter/body_builder'
require 'reporter/data'
require 'reporter/writers'
require 'simple_runner'

module Reporter
  class Runner
    include SimpleRunner

    run do
      shards = Reporter::Data.new.to_a

      unless shards.empty?
        body = Reporter::BodyBuilder.new(shards).lift
        writer.write(body)
      end

      sleep Reporter.config.poll_interval
    end

    def writer
      @writer ||= Reporter.config.dry_run ?
        Reporter::Writers::Pipe.new(STDOUT) :
        Reporter::Writers::Circonus.new(Reporter.config.circonus)
    end
  end
end
