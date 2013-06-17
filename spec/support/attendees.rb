def create_attendees_in_various_states
  10.times do
    create(:attendee)
  end

  Attendee.last(8).map(&:invite!)
  Attendee.last(3).map(&:pay!)
  Attendee.last(2).map(&:remind!)
  Attendee.last(1).map(&:confirm!)
end
