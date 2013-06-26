NullAttendee = Naught.build do |config|
  config.black_hole

  def state
    "invalid"
  end
end
