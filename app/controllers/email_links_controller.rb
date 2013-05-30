class EmailLinksController < ApplicationController
  def confirm
    notice_message = confirm_flash

    begin
      attendee_to_confirm.confirm!
    rescue StateMachine::InvalidTransition

    end

    redirect_to '/', notice: notice_message
  end

  def decline
    notice_message = decline_flash

    begin
      attendee_to_decline.decline!
    rescue StateMachine::InvalidTransition

    end

    redirect_to '/', notice: notice_message
  end

  private

  def attendee_to_confirm
    Attendee.where(confirm_token: decoded_token).first
  end

  def attendee_to_decline
    Attendee.where(decline_token: decoded_token).first
  end

  def decoded_token
    Base64.urlsafe_decode64(params[:token])
  end

  def confirm_flash
    case attendee_to_confirm.state
    when "confirmed"
      "You have already confirmed your attendance."
    when "declined"
      "Sorry you have already declined this event."
    else
      "Your attendence has been confirmed."
    end
  end

  def decline_flash
    case attendee_to_decline.state
    when "declined"
      "Sorry you have already declined this event."
    when "paid"
      "You've already paid"
    when "received_reminder"
      "Your payment has already been accepted"
    else
      "Sorry you can't make it."
    end
  end
end
