require 'spec_helper'
require 'reporter/writers/circonus'

RSpec.describe Reporter::Writers::Circonus do
  subject(:writer) { Reporter::Writers::Circonus.new(url) }
  let(:url) { 'http://127.0.0.1' }
  let(:uri) { URI(url) }
  let(:http) { double('http', request_post: true) }

  before do
    allow(Net::HTTP).to receive(:start).and_yield(http)
  end

  describe '#write' do
    it 'puts to the IO object initialized into the object' do
      writer.write('bladjsfalkfjaljfa')
      expect(http).to have_received(:request_post).with(uri.path, 'bladjsfalkfjaljfa')
    end
  end
end
