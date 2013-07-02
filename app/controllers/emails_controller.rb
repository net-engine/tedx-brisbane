class EmailsController < ApplicationController
  layout "email"

  def content
    if email
      render('emails/content', locals: { email: email, attendee: email.attendee })
    else
      redirect_to '/', notice: message
    end
  end

  private
  def email
    Email.where(token: decoded_token).first
  end

  def decoded_token
    Base64.urlsafe_decode64(params[:token]) rescue "null_token"
  end

  def message
    I18n.t("controllers.emails.invalid")
  end
end
