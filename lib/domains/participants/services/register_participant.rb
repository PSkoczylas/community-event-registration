# frozen_string_literal: true

module Participants
  module Services
    class RegisterParticipant
      attr_reader :event_repository, :participant_repository

      def initialize(event_repository, participant_repository)
        @event_repository = event_repository
        @participant_repository = participant_repository
      end

      def call(event_name, participant_name)
        event = event_repository.find(event_name)
        return 'Event not found' unless event

        participant = participant_repository.find(participant_name) || participant_repository.create_participant(participant_name)

        if event.register_participant(participant)
          "#{participant_name} registered for #{event_name}"
        else
          "Registration failed: #{event_name} is full"
        end
      end
    end
  end
end
