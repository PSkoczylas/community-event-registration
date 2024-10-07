# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ParticipantController do
  let(:event_repository) { Events::EventRepository.new }
  let(:participant_repository) { Participants::ParticipantRepository.new }
  let(:register_participant_service) do
    Participants::Services::RegisterParticipant.new(event_repository, participant_repository)
  end
  let(:list_participants_service) { Participants::Services::ListParticipants.new(event_repository) }
  let(:controller) { described_class.new(register_participant_service, list_participants_service) }
  let(:event_controller) { EventController.new(event_repository) }

  before do
    event_controller.create_event('Ruby Meetup', 2)
  end

  describe '#register_participant' do
    let(:registered_alice) { controller.register_participant('Ruby Meetup', 'Alice') }

    it 'registers a participant for an event' do
      expect(registered_alice).to eq('Alice registered for Ruby Meetup')
    end

    let(:registered_bob) { controller.register_participant('Ruby Meetup', 'Bob') }

    it 'fails to register when the event is full' do
      controller.register_participant('Ruby Meetup', 'Alice')
      controller.register_participant('Ruby Meetup', 'Bob')
      expect(registered_bob).to eq('Registration failed: Ruby Meetup is full')
    end

    let(:event_not_found) { controller.register_participant('Non-existent Event', 'Alice') }
    it 'fails to register for a non-existent event' do
      expect(event_not_found).to eq('Event not found')
    end
  end

  describe '#list_participants' do
    before do
      controller.register_participant('Ruby Meetup', 'Alice')
      controller.register_participant('Ruby Meetup', 'Bob')
    end

    let(:listed_participants) { controller.list_participants('Ruby Meetup') }

    it 'lists participants for an event' do
      expect(listed_participants).to contain_exactly('Alice', 'Bob')
    end

    let(:non_listed_event) { controller.list_participants('Non-existent Event') }

    it 'returns an error for a non-existent event' do
      expect(non_listed_event).to eq('Event not found')
    end
  end
end
