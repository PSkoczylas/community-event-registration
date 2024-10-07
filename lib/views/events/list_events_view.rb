# frozen_string_literal: true

module Events
  class ListEventsView
    def self.call(controller)
      events = controller.list_events
      if events.empty?
        puts 'No events available.'
      else
        puts 'Events:'
        events.each { |event| puts "- #{event}" }
      end
    end
  end
end
