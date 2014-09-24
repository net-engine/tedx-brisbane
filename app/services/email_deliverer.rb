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
    response = self.class.post(url, options)
    if response['error'].present?
      Rails.logger.fatal("Email id #{email.id} could not be delivered\n#{response.with_indifferent_access}")
    end
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
