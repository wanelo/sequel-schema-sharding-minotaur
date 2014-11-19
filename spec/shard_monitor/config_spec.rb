require 'spec_helper'
require 'shard_monitor/config'

RSpec.describe ShardMonitor::Config do
  subject { ShardMonitor::Config.new }

  let(:argv) { %w(--redis redis://blah.com/5) }

  before do
    subject.parse_options argv
  end

  it 'takes command line arguments' do
    expect(subject.redis).to eq('redis://blah.com/5')
  end
end
