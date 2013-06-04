class PaymentsController < ApplicationController
  def new
    unless attendee && attendee.state == "received_invitation"
      redirect_to('/', notice: I18n.t("controllers.payments.invalid")) and return
    end

    render :new, locals: { attendee: attendee, tr_data: tr_data }
  end

  def confirm
    if result.success? && attendee_payment_created
      redirect_to('/', notice: I18n.t("controllers.payments.success"))
    else
      redirect_to new_payment_path(pay_token), notice: "Sorry, your payment was declined."
    end
  end

  private

  def attendee_payment_created
    if attendee.payments.create! amount: result.transaction.amount,
                                 transaction_id: result.transaction.id,
                                 masked_number: result.transaction.credit_card_details.last_4,
                                 card_type: result.transaction.credit_card_details.card_type
      attendee.update_attributes first_name: result.transaction.customer_details.first_name,
                                 last_name: result.transaction.customer_details.last_name
      attendee.pay!
    end
  end

  def result
    @result ||= Braintree::TransparentRedirect.confirm(request.query_string)
  end

  def tr_data
    Braintree::TransparentRedirect.transaction_data(
          redirect_url: confirm_payment_url,
          transaction: { type: "sale",
                         amount: amount,
                         customer: { email: attendee.email_address },
                         custom_fields: { attendee_pay_token: params[:token] },
                         options: { submit_for_settlement: true }})
  end

  def attendee
    Attendee.where(pay_token: decoded_token).first
  end

  def decoded_token
    Base64.urlsafe_decode64(pay_token) rescue "null_token"
  end

  def pay_token
    params[:token] || result.transaction.custom_fields[:attendee_pay_token]
  end

  def amount
    TICKET.price_in_dollars
  end
end
