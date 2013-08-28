class PaymentsController < ApplicationController
  before_action :verify_attendee

  def new
    @attendee         = attendee
    @token            = params[:token]
  end

  def confirm
    PaywayConnector.make_payment!(attendee, params)
    redirect_to('/', notice: I18n.t("controllers.payments.success"))
  rescue Exceptions::TEDXErrorWithPredefinedMessage => e
    redirect_to(new_payment_path(params[:token]), notice: e.message)
  end

  private

  def verify_attendee
    unless attendee && attendee.received_invitation?
      redirect_to('/', notice: I18n.t("controllers.payments.invalid")) and return
    end
  end


  def attendee
    Attendee.where(pay_token: decoded_token).first
  end

  def decoded_token
    Base64.urlsafe_decode64(params[:token]) rescue "null_token"
  end

end
