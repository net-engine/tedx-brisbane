class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :attendee_id, :amount, :transaction_id, :masked_number, :card_type
end
