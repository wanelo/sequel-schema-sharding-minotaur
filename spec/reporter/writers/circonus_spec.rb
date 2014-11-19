require 'spec_helper'
require 'reporter/writers/circonus'

RSpec.describe Reporter::Writers::Circonus do
  subject(:writer) { Reporter::Writers::Circonus.new(url) }
  let(:url) { 'http://127.0.0.1' }
  let(:uri) { URI(url) }

  before do
    allow(Net::HTTP).to receive(:post_form)
  end

  describe '#write' do
    it 'puts to the IO object initialized into the object' do
      writer.write('bladjsfalkfjaljfa')
      expect(Net::HTTP).to have_received(:post_form).with(uri, 'bladjsfalkfjaljfa')
    end
  end
end
