# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Event do
  let(:event) { Event.new('Ruby Meetup', 2) }
  let(:participant1) { Participant.new('Alice') }
  let(:participant2) { Participant.new('Bob') }
  let(:participant3) { Participant.new('Charlie') }

  describe '#initialize' do
    it 'creates an event with a name and capacity' do
      expect(event.name).to eq('Ruby Meetup')
      expect(event.capacity).to eq(2)
      expect(event.participants).to be_empty
    end
  end

  describe '#register_participant' do
    context 'when there is space available' do
      it 'registers the participant' do
        expect(event.register_participant(participant1)).to be true
        expect(event.participants).to include(participant1)
      end
    end

    context 'when the event is at capacity' do
      before do
        event.register_participant(participant1)
        event.register_participant(participant2)
      end

      it 'does not register the participant' do
        expect(event.register_participant(participant3)).to be false
        expect(event.participants).not_to include(participant3)
      end
    end
  end

  describe '#list_participants' do
    before do
      event.register_participant(participant1)
      event.register_participant(participant2)
    end

    it 'returns a list of all registered participants' do
      expect(event.list_participants).to contain_exactly(participant1, participant2)
    end
  end
end
