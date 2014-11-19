require 'spec_helper'
require 'reporter'
require 'reporter/data'

RSpec.describe Reporter::Data do
  subject(:data) { Reporter::Data.new }

  let(:config) { double(Reporter::Config, redis: 'redis://127.0.0.1/1')}
  let(:redis) { Reporter.redis }

  before do
    allow(Reporter).to receive(:config).and_return(config)
  end

  context 'there is no data in redis' do
    it 'returns an empty array' do
      expect(data.to_a).to match_array([])
    end
  end

  context 'there is data in redis' do
    before do
      redis.rpush(1, [5, 6, 7])
      redis.rpush(2, [7, 8, 9])
    end

    it 'returns a flattened array of integers' do
      expect(data.to_a).to match_array([5, 6, 7, 7, 8, 9])
    end
  end
end
