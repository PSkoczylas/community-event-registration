# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Participants::Services::RegisterParticipant do
  let(:event_repository) { instance_double('Events::EventRepository') }
  let(:participant_repository) { instance_double('Participants::ParticipantRepository') }
  let(:service) { described_class.new(event_repository, participant_repository) }

  describe '#call' do
    let(:event) { instance_double('Event') }
    let(:participant) { instance_double('Participant') }

    context 'when the event exists' do
      before do
        allow(event_repository).to receive(:find).with('Ruby Meetup').and_return(event)
      end

      context 'when the participant does not exist' do
        before do
          allow(participant_repository).to receive(:find).with('Alice').and_return(nil)
          allow(participant_repository).to receive(:create_participant).with('Alice').and_return(participant)
        end

        let(:result) { service.call('Ruby Meetup', 'Alice') }

        context 'when registration is successful' do
          before do
            allow(event).to receive(:register_participant).with(participant).and_return(true)
          end

          it 'registers the participant and returns a success message' do
            expect(result).to eq('Alice registered for Ruby Meetup')
          end
        end

        context 'when registration fails' do
          before do
            allow(event).to receive(:register_participant).with(participant).and_return(false)
          end

          it 'returns a failure message' do
            expect(result).to eq('Registration failed: Ruby Meetup is full')
          end
        end
      end

      context 'when the participant already exists' do
        before do
          allow(participant_repository).to receive(:find).with('Alice').and_return(participant)
        end

        context 'when registration is successful' do
          before do
            allow(event).to receive(:register_participant).with(participant).and_return(true)
          end

          let(:result) { service.call('Ruby Meetup', 'Alice') }

          it 'registers the existing participant and returns a success message' do
            expect(result).to eq('Alice registered for Ruby Meetup')
          end
        end
      end
    end

    context 'when the event does not exist' do
      before do
        allow(event_repository).to receive(:find).with('Non-existent Event').and_return(nil)
      end

      it 'returns an error message' do
        result = service.call('Non-existent Event', 'Alice')
        expect(result).to eq('Event not found')
      end
    end
  end
end
