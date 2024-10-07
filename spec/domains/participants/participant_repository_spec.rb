# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/models/participant'
require_relative '../../../lib/domains/participants/participant_repository'

RSpec.describe Participants::ParticipantRepository do
  let(:repository) { described_class.new }

  let!(:participant) { repository.create_participant('Alice') }

  describe '#create_participant' do
    it 'creates a new participant' do
      expect(participant).to be_an_instance_of(Participant)
      expect(participant.name).to eq('Alice')
    end

    it 'stores the created participant' do
      expect(repository.participants['Alice']).to be_an_instance_of(Participant)
    end
  end

  describe '#find' do
    it 'returns the participant when they exist' do
      expect(participant).to be_an_instance_of(Participant)
      expect(participant.name).to eq('Alice')
    end

    it 'returns nil when the participant does not exist' do
      expect(repository.find('Bob')).to be_nil
    end
  end
end
