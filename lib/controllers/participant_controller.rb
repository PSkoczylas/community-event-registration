# frozen_string_literal: true

class ParticipantController
  def initialize(register_participant_service, list_participants_service)
    @register_participant_service = register_participant_service
    @list_participants_service = list_participants_service
  end

  def register_participant(event_name, participant_name)
    @register_participant_service.call(event_name, participant_name)
  end

  def list_participants(event_name)
    @list_participants_service.call(event_name)
  end
end
