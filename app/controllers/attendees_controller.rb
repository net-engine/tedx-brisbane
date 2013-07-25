class AttendeesController < ApplicationController
  def create
    @attendee = Attendee.new(attendee_params)
    if @attendee.save
      @attendee.emails.create(event: 'register').deliver

      respond_to do |format|
        format.html do
          redirect_to "/", notice: 'Thanks for registering!'
        end

        format.js
      end
    else
      respond_to do |format|
        format.html do
          redirect_to "/"
          flash[:error] = @attendee.errors.full_messages.join(', ')
        end

        format.js
      end
    end
  end

  private

  def attendee_params
    params.require(:attendee).permit(:first_name, :last_name, :email_address, :gender, :age, :profession, :tweet_idea, :scholarship)
  end

end