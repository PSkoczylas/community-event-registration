# frozen_string_literal: true

require_relative 'lib/models/event'
require_relative 'lib/models/participant'
require_relative 'lib/controllers/event_controller'
require_relative 'lib/controllers/participant_controller'
require_relative 'lib/domains/events/event_repository'
require_relative 'lib/domains/participants/participant_repository'
require_relative 'lib/domains/participants/services/list_participants'
require_relative 'lib/domains/participants/services/register_participant'
require_relative 'lib/views/events/event_menu_view'
require_relative 'lib/views/events/create_event_view'
require_relative 'lib/views/events/list_events_view'
require_relative 'lib/views/events/show_registered_events_view'
require_relative 'lib/views/participants/list_participants_view'
require_relative 'lib/views/participants/register_participant_view'

def run_organiser_menu(event_controller, participant_controller)
  loop do
    Events::EventMenuView.display_organiser_menu
    choice = gets.chomp

    case choice
    when '1'
      Events::CreateEventView.call(event_controller)
    when '2'
      Events::ListEventsView.call(event_controller)
    when '3'
      Participants::ListParticipantsView.call(participant_controller)
    when '4'
      break
    else
      puts 'Invalid choice. Please try again.'
    end
  end
end

def run_participant_menu(event_controller, participant_controller)
  loop do
    Events::EventMenuView.display_participant_menu
    choice = gets.chomp

    case choice
    when '1'
      Participants::RegisterParticipantView.call(participant_controller)
    when '2'
      Events::ShowRegisteredEventsView.call(event_controller)
    when '3'
      break
    else
      puts 'Invalid choice. Please try again.'
    end
  end
end

def main
  event_repository = Events::EventRepository.new
  participant_repository = Participants::ParticipantRepository.new
  list_participants_service = Participants::Services::ListParticipants.new(event_repository)
  register_participant_service = Participants::Services::RegisterParticipant.new(event_repository,
                                                                                 participant_repository)

  event_controller = EventController.new(event_repository)
  participant_controller = ParticipantController.new(register_participant_service, list_participants_service)

  loop do
    role = Events::EventMenuView.ask_user_role

    case role
    when '1'
      run_organiser_menu(event_controller, participant_controller)
    when '2'
      run_participant_menu(event_controller, participant_controller)
    else
      puts 'Invalid role. Please try again.'
    end

    print 'Do you want to switch roles or exit? (switch/exit): '
    decision = gets.chomp.downcase
    break if decision == 'exit'
  end

  puts 'Thank you for using the Event Registration System. Goodbye!'
end

main
