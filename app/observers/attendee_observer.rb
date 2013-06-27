class AttendeeObserver < ActiveRecord::Observer
  observe :attendee

  def after_create(resource)
    RealtimeStatisticsWorker.perform_async
  end

  def after_update(resource)
    RealtimeStatisticsWorker.perform_async
  end

  def after_save(resource)
    RealtimeStatisticsWorker.perform_async
  end

  def after_destroy(resource)
    RealtimeStatisticsWorker.perform_async
  end
end
