class EmailLink
  attr_reader :attendee

  def self.confirm(attendee)
    new(attendee).confirm
  end

  def self.pay(attendee)
    new(attendee).pay
  end

  def self.decline(attendee)
    new(attendee).decline
  end

  def initialize(attendee)
    @attendee = attendee
  end

  def confirm
    Addressable::URI.escape("#{protocol}://#{host_name}/confirm/#{confirm_token}")
  end

  def pay
    Addressable::URI.escape("#{protocol}://#{host_name}/pay/#{pay_token}")
  end

  def decline
    Addressable::URI.escape("#{protocol}://#{host_name}/decline/#{decline_token}")
  end

  private
  def protocol
    Rails.env == 'production' ? 'https' : 'http'
  end

  def host_name
    HOSTNAME.public_send(Rails.env)
  end

  def confirm_token
    Base64.urlsafe_encode64(attendee.confirm_token)
  end

  def pay_token
    Base64.urlsafe_encode64(attendee.pay_token)
  end

  def decline_token
    Base64.urlsafe_encode64(attendee.decline_token)
  end
end
