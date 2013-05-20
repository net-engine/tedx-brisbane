class Email < ActiveRecord::Base
  belongs_to :attendee

  def to_name
    attendee.fullname
  end

  def to_address
    attendee.email_address
  end

  def deliver
    EmailDeliveryWorker.perform_async(id)
  end

  def plain_text_content
    EmailContent.for attendee: attendee, event: event
  end
end
