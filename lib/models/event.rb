# frozen_string_literal: true

class Event
  attr_reader :name, :capacity, :participants

  def initialize(name, capacity)
    @name = name
    @capacity = capacity
    @participants = []
  end

  def register_participant(participant)
    return false if participants.size >= capacity

    participants << participant
    true
  end

  def list_participants
    participants
  end
end
