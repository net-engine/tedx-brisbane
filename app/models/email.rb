class Email < ActiveRecord::Base
  belongs_to :attendee

  validates :event, :attendee, presence: true
  validates :token, uniqueness: true

  before_create :build_token

  def to_name
    attendee.full_name
  end

  def to_address
    attendee.email_address
  end

  def deliver
    EmailDeliveryWorker.perform_async(id)
  end

  def html
    EmailContent.for attendee: attendee, email: self
  end

  def to_json
    EmailSerializer.new(self).to_json
  end

  private
  def build_token
    self.token = BCrypt::Password.create("#{Time.now.to_f}_#{self.to_address}")
  end
end
