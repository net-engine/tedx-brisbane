class EmailContent
  attr_reader :email, :attendee

  def self.for(args = {})
    raise ArgumentError, "Please supply an attendee" unless args[:attendee]
    raise ArgumentError, "Please supply an email" unless args[:email]

    self.new(args).content
  end

  def initialize(args)
    @email = args[:email]
    @attendee = args[:attendee]
  end

  def content
    if recognised_events.include?(email.event)
      render_html
    else
      raise Exceptions::EmailEventNotRecognised
    end
  end

  private

  def recognised_events
    %w(register invite provide_complimentary_ticket revoke_invitation pay decline remind confirm)
  end

  def render_html
    ActionController::Base.new.render_to_string('emails/content', locals: { email: email, attendee: attendee })
  end
end
