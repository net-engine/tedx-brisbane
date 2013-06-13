require 'spec_helper'
require 'sidekiq/testing'

describe RealtimeStatisticsWorker do
  it "calls Pusher" do
    pusher = double('pusher')
    pusher.stub(:trigger)
    Pusher.stub(:[]).and_return(pusher)

    payload = double('payload')
    AttendeeStatisticsSerializer.stub(:new).and_return(payload)

    Pusher.should_receive(:[]).with("attendee-statistics")
    pusher.should_receive(:trigger).with("update", payload)

    RealtimeStatisticsWorker.perform_async
    RealtimeStatisticsWorker.drain
  end
end
