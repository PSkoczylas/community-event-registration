# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Participants::Services::ListParticipants do
  let(:event_repository) { instance_double('Events::EventRepository') }
  let(:service) { described_class.new(event_repository) }

  describe '#call' do
    context 'when the event exists' do
      let(:event) { instance_double('Event') }
      let(:participant1) { instance_double('Participant', name: 'Alice') }
      let(:participant2) { instance_double('Participant', name: 'Bob') }

      before do
        allow(event_repository).to receive(:find).with('Ruby Meetup').and_return(event)
        allow(event).to receive(:list_participants).and_return([participant1, participant2])
      end

      it 'returns a list of participant names' do
        result = service.call('Ruby Meetup')
        expect(result).to eq(%w[Alice Bob])
      end
    end

    context 'when the event does not exist' do
      before do
        allow(event_repository).to receive(:find).with('Non-existent Event').and_return(nil)
      end

      let(:result) { service.call('Non-existent Event') }
      it 'returns an error message' do
        expect(result).to eq('Event not found')
      end
    end
  end
end
