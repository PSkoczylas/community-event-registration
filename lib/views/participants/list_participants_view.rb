# frozen_string_literal: true

module Participants
  class ListParticipantsView
    def self.call(controller)
      print 'Enter event name: '
      event_name = gets.chomp
      participants = controller.list_participants(event_name)
      if participants.is_a?(Array)
        puts "Participants for '#{event_name}':"
        participants.each { |participant| puts "- #{participant}" }
      else
        puts participants
      end
    end
  end
end
