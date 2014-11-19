require 'spec_helper'
require 'reporter/writers/pipe'

RSpec.describe Reporter::Writers::Pipe do
  subject(:writer) { Reporter::Writers::Pipe.new(stdout) }
  let(:stdout) { double('stdout', puts: true) }

  describe '#write' do
    it 'puts to the IO object initialized into the object' do
      writer.write('bladjsfalkfjaljfa')
      expect(stdout).to have_received(:puts).with('bladjsfalkfjaljfa')
    end
  end
end
