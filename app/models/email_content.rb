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
    if recognised_events.include?(event)
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
    ActionController::Base.new.render_to_string('emails/content', locals: { event: event, attendee: attendee })
  end
end
