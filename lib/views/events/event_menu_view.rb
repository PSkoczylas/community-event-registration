# frozen_string_literal: true

module Events
  class EventMenuView
    def self.ask_user_role
      puts 'Who are you?'
      puts '1. Event Organiser'
      puts '2. Participant'
      print 'Enter your role (1 or 2): '
      gets.chomp
    end

    def self.display_organiser_menu
      puts "\nEvent Organiser Menu:"
      puts '1. Create a new event'
      puts '2. List all events'
      puts '3. List participants for an event'
      puts '4. Exit/Change role'
      print 'Enter the number of your action: '
    end

    def self.display_participant_menu
      puts "\nParticipant Menu:"
      puts '1. Register for an event'
      puts '2. View registered events'
      puts '3. Exit/Change role'
      print 'Enter the number of your action: '
    end
  end
end
