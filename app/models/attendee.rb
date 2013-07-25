class Attendee < ActiveRecord::Base
  GENDERS = %w(M F)

  has_many :emails, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :pay_token, :decline_token, :confirm_token, uniqueness: true
  validates :email_address,
            presence: true,
            uniqueness: true,
            format: { with: /\A[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}\z/i }

  validates :first_name, :last_name, :gender, :age, :profession, :tweet_idea, presence: true
  validates :gender, inclusion:   { in: GENDERS }, presence: true
  validates :age,    inclusion:   { in: 5..150  }, presence: true

  before_create :build_tokens

  def self.statistics
    OpenStruct.new(self.all.group("state").count)
  end

  state_machine initial: :awaiting_invitation do
    event :invite do
      transition awaiting_invitation: :received_invitation
    end

    event :provide_complimentary_ticket do
      transition awaiting_invitation: :received_complimentary_ticket,
                 received_invitation: :received_complimentary_ticket
    end

    event :revoke_invitation do
      transition received_invitation: :awaiting_invitation
    end

    event :pay do
      transition received_invitation: :paid
    end

    event :decline do
      transition awaiting_invitation: :declined,
                 received_invitation: :declined,
                 received_complimentary_ticket: :declined
    end

    event :remind do
      transition paid: :received_reminder,
                 received_complimentary_ticket: :received_reminder
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

  def full_name
    "#{first_name} #{last_name}"
  end

  def update_student_attribute(amount)
    case amount.to_i
    when TICKET.price_in_dollars
      update_column(:student, false)
    when TICKET.price_in_dollars_for_student
      update_column(:student, true)
    else
      raise 'Invalid amount'
    end
  end

  private

  def build_tokens
    self.pay_token = BCrypt::Password.create("#{self.email_address}-pay")
    self.decline_token = BCrypt::Password.create("#{self.email_address}-decline")
    self.confirm_token = BCrypt::Password.create("#{self.email_address}-confirm")
  end
end
