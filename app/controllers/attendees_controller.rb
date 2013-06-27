class AttendeesController < ApplicationController
  def create
    @attendee = Attendee.new(attendee_params)
    if @attendee.save
      @attendee.emails.create(event: 'register').deliver
      redirect_to "/", notice: 'Thanks for registering!'
    else
      flash.now[:error] = @attendee.errors.full_messages.join(', ')
      render "pages/index"
    end
  end

  private

  def attendee_params
    params.require(:attendee).permit(:first_name, :last_name, :email_address)
  end

end
