# frozen_string_literal: true

module Participants
  class ParticipantRepository
    attr_reader :participants

    def initialize
      @participants = {}
    end

    def create_participant(name)
      participants[name] = Participant.new(name)
    end

    def find(name)
      participants[name]
    end
  end
end
