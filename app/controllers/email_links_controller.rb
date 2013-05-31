class EmailLinksController < ApplicationController
  def confirm
    begin
      attendee.confirm!
    rescue StateMachine::InvalidTransition
    end
    redirect_to '/', notice: message("confirm")
  end

  def decline
    begin
      attendee.decline!
    rescue StateMachine::InvalidTransition
    end
    redirect_to '/', notice: message("decline")
  end

  def pay
    redirect_to '/', notice: message("pay")
  end

  private

  def message(event)
    I18n.t("controllers.email_links.#{event}_#{attendee.state}")
  end

  def attendee
    case params[:action]
    when "confirm"
      Attendee.where(confirm_token: decoded_token).first || NullAttendee.new
    when "decline"
      Attendee.where(decline_token: decoded_token).first || NullAttendee.new
    when "pay"
      Attendee.where(pay_token: decoded_token).first || NullAttendee.new
    end
  end

  def decoded_token
    Base64.urlsafe_decode64(params[:token]) rescue "null_token"
  end
end
