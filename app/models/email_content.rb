class EmailContent
  attr_reader :event, :attendee

  def self.for(args = {})
    raise ArgumentError, "Please supply an attendee" unless args[:attendee]
    raise ArgumentError, "Please supply an event" unless args[:event]

    self.new(args).content
  end

  def initialize(args)
    @event = args[:event]
    @attendee = args[:attendee]
  end

  def content
    case event
    when "invite"
      "Hi, #{email_address}. You've been invited!!"
    when "revoke_invitation"
      "Sorry, #{email_address}. You took too long, so your invitation has been revoked. Better luck next time!!"
    else
      "Sorry, #{email_address}. I don't know why I'm emailing you."
    end
  end

  private

  def email_address
    attendee.email_address
  end
end
