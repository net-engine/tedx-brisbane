class RealtimeStatisticsWorker
  include Sidekiq::Worker

  def perform
    Pusher['attendee-statistics'].trigger('update', statistics)
  end

  private

  def statistics
    AttendeeStatisticsSerializer.new(Attendee.statistics)
  end
end
