class Payment < ActiveRecord::Base
  validates :attendee_id, :amount, :receipt_number, :masked_number, :card_type, presence: true
end

