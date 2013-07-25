class EmailLinksController < ApplicationController
  def confirm
    begin
      attendee.confirm!
      attendee.emails.create(event: 'confirm').deliver
    rescue StateMachine::InvalidTransition
    end
    redirect_to '/', notice: message("confirm")
  end

  def decline
    begin
      attendee.decline!
      attendee.emails.create(event: 'decline_from_user').deliver
    rescue StateMachine::InvalidTransition
    end
    redirect_to '/', notice: message("decline")
  end

  def pay
    if attendee.state == 'received_invitation'
      redirect_to new_payment_path(params[:token])
    else
      redirect_to '/', notice: message("pay")
    end
  end

  private

  def message(event)
    I18n.t("controllers.email_links.#{event}_#{attendee.state}")
  end

  def attendee
    case params[:action]
    when "confirm"
      Attendee.where(confirm_token: decoded_token).first || NullAttendee.get
    when "decline"
      Attendee.where(decline_token: decoded_token).first || NullAttendee.get
    when "pay"
      Attendee.where(pay_token: decoded_token).first || NullAttendee.get
    end
  end

  def decoded_token
    Base64.urlsafe_decode64(params[:token]) rescue "null_token"
  end
end
