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
    Addressable::URI.escape("https://#{host_name}/confirm/#{confirm_token}")
  end

  def pay
    Addressable::URI.escape("https://#{host_name}/pay/#{pay_token}")
  end

  def decline
    Addressable::URI.escape("https://#{host_name}/decline/#{decline_token}")
  end

  private

  def host_name
    "www.example.com"
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
