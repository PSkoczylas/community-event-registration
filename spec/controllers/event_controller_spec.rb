# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EventController do
  let(:event_repository) { Events::EventRepository.new }
  let(:controller) { described_class.new(event_repository) }

  describe '#create_event' do
    let(:result) { controller.create_event('Ruby Meetup', 50) }

    it 'creates a new event' do
      expect(result).to eq("Event 'Ruby Meetup' created with capacity 50")
      expect(event_repository.find('Ruby Meetup')).to be_an_instance_of(Event)
    end
  end

  describe '#list_events' do
    before do
      controller.create_event('Ruby Meetup', 50)
      controller.create_event('Python Conference', 100)
    end

    it 'returns a list of all events' do
      expect(controller.list_events).to contain_exactly('Ruby Meetup', 'Python Conference')
    end
  end

  describe '#list_events_for_participant' do
    let(:participant_controller) { ParticipantController.new(register_participant_service, list_participants_service) }
    let(:register_participant_service) do
      Participants::Services::RegisterParticipant.new(event_repository, participant_repository)
    end
    let(:list_participants_service) { Participants::Services::ListParticipants.new(event_repository) }
    let(:participant_repository) { Participants::ParticipantRepository.new }

    before do
      controller.create_event('Ruby Meetup', 50)
      controller.create_event('Python Conference', 100)
      participant_controller.register_participant('Ruby Meetup', 'Alice')
      participant_controller.register_participant('Python Conference', 'Alice')
      participant_controller.register_participant('Ruby Meetup', 'Bob')
    end

    it 'returns a list of events for a specific participant' do
      expect(controller.list_events_for_participant('Alice')).to contain_exactly('Ruby Meetup', 'Python Conference')
      expect(controller.list_events_for_participant('Bob')).to contain_exactly('Ruby Meetup')
    end
  end
end
