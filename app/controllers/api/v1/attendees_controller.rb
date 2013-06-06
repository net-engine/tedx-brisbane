class Api::V1::AttendeesController < Api::V1::BaseController
  def statistics
    respond_with attendee_statistics, serializer: AttendeeStatisticsSerializer
  end

  def create
    render json: created_attendees, each_serializer: AttendeeSerializer, status: :created
  end

  private

  def created_attendees
    [].tap do |collection|
      supplied_attendees.each do |attendee_params|
        collection << Attendee.create(attendee_params.slice("email_address"))
      end
    end
  end

  def supplied_attendees
    params.require(:attendees)
  end

  def attendee_statistics
    OpenStruct.new(attendee_state_count)
  end

  def attendee_state_count
    Attendee.all.group("state").count
  end
end
