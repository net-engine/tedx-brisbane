class Attendee < ActiveRecord::Base
  has_many :emails

  validates :email_address,
            presence: true,
            uniqueness: true,
            format: { with: /\A[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}\z/i }

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
      transition received_invitation: :declined, received_reminder: :declined
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
end
