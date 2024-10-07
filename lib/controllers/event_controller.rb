# frozen_string_literal: true

class EventController
  def initialize(event_repository)
    @event_repository = event_repository
  end

  def create_event(name, capacity)
    @event_repository.create_event(name, capacity)
  end

  def list_events
    @event_repository.all
  end

  def list_events_for_participant(participant_name)
    @event_repository.events_for_participant(participant_name)
  end
end
