# frozen_string_literal: true

module Events
  class ShowRegisteredEventsView
    def self.call(controller)
      print 'Enter your name: '
      participant_name = gets.chomp
      events = controller.list_events_for_participant(participant_name)
      if events.empty?
        puts 'You are not registered for any events.'
      else
        puts 'Events you are registered for:'
        events.each { |event| puts "- #{event}" }
      end
    end
  end
end
