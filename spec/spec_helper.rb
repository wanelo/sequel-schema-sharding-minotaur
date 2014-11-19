Bundler.require :test, :development

require 'reporter'
require 'shard_monitor'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.after :each do
    [Reporter, ShardMonitor].each do |klass|
      [:@redis, :@config].each do |var|
        next unless klass.instance_variable_get(var)
        klass.send(:remove_instance_variable, var)
      end
    end
  end
end
