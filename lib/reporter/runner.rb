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
        writers.each { |w| w.write(body) }
      end

      sleep Reporter.config.poll_interval
    end

    attr_reader :writers

    def initialize
      @writers = []
      writers << Reporter::Writers::Pipe.new(STDOUT) if Reporter.config.debug
      writers << Reporter::Writers::Circonus.new(Reporter.config.circonus) unless Reporter.config.dry_run
    end
  end
end
