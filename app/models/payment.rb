class Payment < ActiveRecord::Base
  validates  :attendee_id, :amount, :transaction_id, :masked_number, :card_type, presence: true
  belongs_to :attendee

  def usual_amount
    TICKET.price_in_dollars
  end

  def tr_data(confirm_payment_url, token)
    Braintree::TransparentRedirect.transaction_data(
      redirect_url: confirm_payment_url,
      transaction: { type: "sale",
                     amount: usual_amount,
                     customer: { email: attendee.email_address },
                     custom_fields: { attendee_pay_token: token },
                     options: { submit_for_settlement: true }})
  end

  def self.create_and_pay(attendee, result)
    if attendee.payments.create! amount: result.transaction.amount,
                                 transaction_id: result.transaction.id,
                                 masked_number: result.transaction.credit_card_details.last_4,
                                 card_type: result.transaction.credit_card_details.card_type
      attendee.update_attributes first_name: result.transaction.customer_details.first_name,
                                 last_name: result.transaction.customer_details.last_name
      attendee.pay!
    end
  end
end
