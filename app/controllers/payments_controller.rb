class PaymentsController < ApplicationController
  def new
    redirect_to('/', notice: I18n.t("controllers.email_links.pay_invalid")) unless attendee
  end

  def confirm
    # @result = Braintree::TransparentRedirect.confirm(request.query_string)
    # if @result.success?
    #   render :action => "confirm"
    # else
    #   @amount = calculate_amount
    #   render :action => "new"
    # end
  end

  private

  def attendee
    @attendee = Attendee.where(pay_token: decoded_token).first
  end

  def decoded_token
    Base64.urlsafe_decode64(params[:token]) rescue "null_token"
  end
end
