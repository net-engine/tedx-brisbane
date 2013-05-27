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
    self.class.post(url, options)
  end

  private

  def url
    "https://mandrillapp.com/api/1.0/messages/send.json"
  end

  def options
    {
      body: email.to_json,
      headers: {
        'Accept' => 'application/json',
        'Content-type' => 'application/json'
      }
    }
  end
end
