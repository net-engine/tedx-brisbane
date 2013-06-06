class Api::V1::AttendeesController < Api::V1::BaseController
  def statistics
    respond_with attendee_statistics, serializer: AttendeeStatisticsSerializer
  end

  private

  def attendee_statistics
    OpenStruct.new(attendee_state_count)
  end

  def attendee_state_count
    Attendee.all.group("state").count
  end
end
