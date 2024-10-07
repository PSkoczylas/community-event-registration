# frozen_string_literal: true

module Events
  class CreateEventView
    def self.call(controller)
      print 'Enter event name: '
      name = gets.chomp
      print 'Enter event capacity: '
      capacity = gets.chomp.to_i
      result = controller.create_event(name, capacity)
      puts result
    end
  end
end
