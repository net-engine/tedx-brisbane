class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :attendee_id, :amount, :receipt_number, :masked_number, :card_type
end
