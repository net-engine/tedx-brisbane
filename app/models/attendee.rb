class Attendee < ActiveRecord::Base
  has_many :emails

  validates :pay_token, :decline_token, :confirm_token, uniqueness: true
  validates :email_address,
            presence: true,
            uniqueness: true,
            format: { with: /\A[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}\z/i }

  before_create :build_tokens

  state_machine initial: :awaiting_invitation do
    event :invite do
      transition awaiting_invitation: :received_invitation
    end

    event :revoke_invitation do
      transition received_invitation: :awaiting_invitation
    end

    event :pay do
      transition received_invitation: :paid
    end

    event :decline do
      transition received_invitation: :declined,
                 awaiting_invitation: :declined
    end

    event :remind do
      transition paid: :received_reminder
    end

    event :confirm do
      transition received_reminder: :confirmed
    end

    after_transition on: :revoke_invitation, do: :increment_round!
  end

  def increment_round!
    self.round += 1
    save!
  end

  def fullname
    email_address
  end

  private

  def build_tokens
    self.pay_token = BCrypt::Password.create("#{self.email_address}-pay")
    self.decline_token = BCrypt::Password.create("#{self.email_address}-decline")
    self.confirm_token = BCrypt::Password.create("#{self.email_address}-confirm")
  end
end
