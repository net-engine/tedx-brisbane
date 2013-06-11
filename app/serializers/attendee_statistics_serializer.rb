class AttendeeStatisticsSerializer < ActiveModel::Serializer
  STATES = Attendee.new.state_paths.to_states

  STATES.each do |state|
    attributes state
    define_method state do
      object.public_send(state) || 0
    end
  end
end
