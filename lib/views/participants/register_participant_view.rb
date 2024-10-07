# frozen_string_literal: true

module Participants
  class RegisterParticipantView
    def self.call(controller)
      print 'Enter your name: '
      participant_name = gets.chomp
      print 'Enter event name: '
      event_name = gets.chomp
      result = controller.register_participant(event_name, participant_name)
      puts result
    end
  end
end
