# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/models/event'
require_relative '../../../lib/domains/events/event_repository'

RSpec.describe Events::EventRepository do
  let(:repository) { described_class.new }

  describe '#create_event' do
    let(:event) { repository.create_event('Ruby Meetup', 50) }

    it 'creates a new event and returns a success message' do
      expect(event).to eq("Event 'Ruby Meetup' created with capacity 50")
      expect(repository.events['Ruby Meetup']).to be_an_instance_of(Event)
    end
  end

  describe '#all' do
    before do
      repository.create_event('Ruby Meetup', 50)
      repository.create_event('Python Conference', 100)
    end

    it 'returns all event names' do
      expect(repository.all).to contain_exactly('Ruby Meetup', 'Python Conference')
    end
  end

  describe '#find' do
    before do
      repository.create_event('Ruby Meetup', 50)
    end

    let(:event) { repository.find('Ruby Meetup') }

    it 'returns the event when it exists' do
      expect(event).to be_an_instance_of(Event)
      expect(event.name).to eq('Ruby Meetup')
    end

    it 'returns nil when the event does not exist' do
      expect(repository.find('Non-existent Event')).to be_nil
    end
  end

  describe '#events_for_participant' do
    let(:event1) { Event.new('Ruby Meetup', 50) }
    let(:event2) { Event.new('Python Conference', 100) }
    let(:participant) { Participant.new('Alice') }

    before do
      repository.events['Ruby Meetup'] = event1
      repository.events['Python Conference'] = event2
      event1.register_participant(participant)
    end

    it 'returns events the participant is registered for' do
      expect(repository.events_for_participant('Alice')).to contain_exactly('Ruby Meetup')
    end

    it 'returns an empty array when the participant is not registered for any events' do
      expect(repository.events_for_participant('Bob')).to be_empty
    end
  end
end
