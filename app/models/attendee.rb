class Attendee < ActiveRecord::Base
  validates :email_address, presence: true, uniqueness: true
end
