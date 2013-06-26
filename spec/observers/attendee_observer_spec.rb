require 'spec_helper'

describe AttendeeObserver, enable_observer: true do
  let(:observer) { AttendeeObserver.instance }
  let(:record) { double('record') }

  describe "#after_create" do
    it "should create a RealtimeStatisticsWorker" do
      RealtimeStatisticsWorker.should_receive(:perform_async)

      observer.after_create(record)
    end
  end

  describe "#after_update" do
    it "should create a RealtimeStatisticsWorker" do
      RealtimeStatisticsWorker.should_receive(:perform_async)

      observer.after_update(record)
    end
  end

  describe "#after_save" do
    it "should create a RealtimeStatisticsWorker" do
      RealtimeStatisticsWorker.should_receive(:perform_async)

      observer.after_save(record)
    end
  end

  describe "#after_destroy" do
    it "should create a RealtimeStatisticsWorker" do
      RealtimeStatisticsWorker.should_receive(:perform_async)

      observer.after_destroy(record)
    end
  end
end
