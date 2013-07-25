class PaymentsController < ApplicationController
  before_action :verify_attendee, only: :new

  def new
    @attendee         = attendee
    @tr_data          = tr_data
    @tr_data_student  = tr_data(true)
    render :new
  end

  def confirm
    if result.success? && attendee_payment_created
      redirect_to('/', notice: I18n.t("controllers.payments.success"))
      session[:pay_token] = nil
    else
      redirect_to(new_payment_path(pay_token), notice: I18n.t("controllers.payments.failure"))
    end
  end

  private

  def verify_attendee
    unless attendee && attendee.received_invitation?
      redirect_to('/', notice: I18n.t("controllers.payments.invalid")) and return
    end
  end

  def attendee_payment_created
    Attendee.transaction do
      if attendee.payments.create! amount: result.transaction.amount,
                                   transaction_id: result.transaction.id,
                                   masked_number: result.transaction.credit_card_details.last_4,
                                   card_type: result.transaction.credit_card_details.card_type
        attendee.update_attributes first_name: result.transaction.customer_details.first_name,
                                   last_name: result.transaction.customer_details.last_name
        attendee.pay!
        attendee.update_student_status(result.transaction.amount)
        attendee.emails.create(event: 'pay').deliver
      end
    end
  rescue
    false
  end

  def result
    @result ||= Braintree::TransparentRedirect.confirm(request.query_string)
  end

  def tr_data(student = false)
    Braintree::TransparentRedirect.transaction_data(
          redirect_url: confirm_payment_url,
          transaction: { type: "sale",
                         amount: amount(student),
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
    session[:pay_token] ||= params[:token]
  end

  def amount(student)
    student ? TICKET.price_in_dollars_for_student : TICKET.price_in_dollars
  end
end
