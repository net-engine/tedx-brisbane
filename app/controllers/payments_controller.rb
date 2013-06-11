class PaymentsController < ApplicationController
  before_action :verify_attendee, only: :new

  def new
    new_payment = Payment.new(attendee_id: attendee.id)
    render :new, locals: { attendee: attendee, tr_data: new_payment.tr_data(confirm_payment_url, params[:token]) }
  end

  def confirm
    if result.success? && Payment.create_and_pay(attendee, result)
      redirect_to('/', notice: I18n.t("controllers.payments.success"))
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

  def result
    @result ||= Braintree::TransparentRedirect.confirm(request.query_string)
  end

  def attendee
    Attendee.by_token(pay_token).first
  end

  def pay_token
    params[:token] || result.transaction.custom_fields[:attendee_pay_token]
  end

end
