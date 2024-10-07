# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Participant do
  describe '#initialize' do
    let(:participant) { Participant.new('Alice') }
    it 'creates a participant with a name' do
      expect(participant.name).to eq('Alice')
    end
  end
end
