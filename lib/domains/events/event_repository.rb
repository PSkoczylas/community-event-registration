# frozen_string_literal: true

module Events
  class EventRepository
    attr_reader :events

    def initialize
      @events = {}
    end

    def create_event(name, capacity)
      events[name] = Event.new(name, capacity)
      "Event '#{name}' created with capacity #{capacity}"
    end

    def all
      events.keys
    end

    def find(name)
      events[name]
    end

    def events_for_participant(participant_name)
      events.values.select { |event| event.participants.any? { |p| p.name == participant_name } }.map(&:name)
    end
  end
end
