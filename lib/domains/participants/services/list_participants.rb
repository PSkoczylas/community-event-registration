# frozen_string_literal: true

module Participants
  module Services
    class ListParticipants
      attr_accessor :event_repository

      def initialize(event_repository)
        @event_repository = event_repository
      end

      def call(event_name)
        event = event_repository.find(event_name)
        return 'Event not found' unless event

        event.list_participants.map(&:name)
      end
    end
  end
end
