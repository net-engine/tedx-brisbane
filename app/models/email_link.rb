class EmailLink
  attr_reader :resource

  def self.confirm(resource)
    new(resource).confirm
  end

  def self.pay(resource)
    new(resource).pay
  end

  def self.decline(resource)
    new(resource).decline
  end

  def self.for(resource)
    new(resource).for
  end

  def initialize(resource)
    @resource = resource
  end

  def for
    Addressable::URI.escape("#{host_name}/#{route}/#{token}")
  end

  def confirm
    Addressable::URI.escape("#{host_name}/confirm/#{confirm_token}")
  end

  def pay
    Addressable::URI.escape("#{host_name}/pay/#{pay_token}")
  end

  def decline
    Addressable::URI.escape("#{host_name}/decline/#{decline_token}")
  end

  private
  def host_name
    HOSTNAME.public_send(Rails.env)
  end

  def route
    resource.class.to_s.downcase.pluralize
  end

  def token
    Base64.urlsafe_encode64(resource.token)
  end

  def confirm_token
    Base64.urlsafe_encode64(resource.confirm_token)
  end

  def pay_token
    Base64.urlsafe_encode64(resource.pay_token)
  end

  def decline_token
    Base64.urlsafe_encode64(resource.decline_token)
  end
end
