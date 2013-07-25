class Api::V1::AttendeesController < Api::V1::BaseController
  def statistics
    respond_with attendee_statistics, serializer: AttendeeStatisticsSerializer
  end

  def create
    render json: created_attendees, each_serializer: AttendeeSerializer, status: :created
  end

  private

  def attendee_statistics
    Attendee.statistics
  end

  def created_attendees
    [].tap do |collection|
      supplied_attendees.each do |attendee_params|
        collection << Attendee.create(attendee_params.slice("email_address", "first_name", "last_name", "gender", "age",
                                                            "profession", "tweet_idea", "scholarship"))
      end
    end
  end

  def supplied_attendees
    params.require(:attendees)
  end
end
