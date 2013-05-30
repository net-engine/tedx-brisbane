class EmailLinksController < ApplicationController
  def confirm
    attendee_to_confirm.confirm! rescue StateMachine::InvalidTransition
    redirect_to '/', notice: message("confirm")
  end

  def decline
    attendee_to_decline.decline! rescue StateMachine::InvalidTransition
    redirect_to '/', notice: message("decline")
  end

  private

  def message(event)
    I18n.t("controllers.email_links.#{event}_#{@attendee.state}")
  end

  def attendee_to_confirm
    @attendee ||= Attendee.where(confirm_token: decoded_token).first
  end

  def attendee_to_decline
    @attendee ||= Attendee.where(decline_token: decoded_token).first
  end

  def decoded_token
    Base64.urlsafe_decode64(params[:token])
  end
end
