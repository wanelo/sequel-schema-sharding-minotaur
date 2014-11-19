require 'spec_helper'
require 'reporter/config'

RSpec.describe Reporter::Config do
  subject { Reporter::Config.new }

  let(:argv) { %w(--redis redis://blah.com/5 --circonus http://blah.com --poll-interval 1234) }

  before do
    subject.parse_options argv
  end

  it 'takes command line arguments' do
    expect(subject.redis).to eq('redis://blah.com/5')
    expect(subject.circonus).to eq('http://blah.com')
    expect(subject.poll_interval).to eq(1234)
  end
end
