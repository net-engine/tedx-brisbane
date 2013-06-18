class PagesController < ApplicationController
  def index
    @attendee = Attendee.new
  end
end
