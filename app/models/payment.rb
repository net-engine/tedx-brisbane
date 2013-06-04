class Payment < ActiveRecord::Base
  validates :attendee_id, :amount, :transaction_id, :masked_number, :card_type, presence: true
end
