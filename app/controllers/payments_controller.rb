class PaymentsController < ApplicationController
  def new
    redirect_to('/', notice: I18n.t("controllers.email_links.pay_invalid")) unless attendee

    @tr_data = Braintree::TransparentRedirect.transaction_data(
      redirect_url: confirm_payment_url,
      transaction: {type: "sale", amount: amount, options: { submit_for_settlement: true }})
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

  def amount
    TICKET_PRICE_IN_DOLLARS
  end
end
