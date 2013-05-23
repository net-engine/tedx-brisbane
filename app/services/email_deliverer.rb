class EmailDeliverer
  include HTTParty

  attr_reader :email

  def self.deliver(id)
    new(id).deliver
  end

  def initialize(id)
    @email = Email.find(id)
  end

  def deliver
    self.class.post {}
  end
end
