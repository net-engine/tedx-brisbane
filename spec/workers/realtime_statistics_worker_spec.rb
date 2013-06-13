require 'spec_helper'
require 'sidekiq/testing'

describe RealtimeStatisticsWorker do
  it "calls Pusher" do
    pusher = double('pusher').as_null_object
    Pusher.stub(:[]).and_return(pusher)
    Pusher.should_receive(:[]).with("attendee-statistics")

    RealtimeStatisticsWorker.perform_async
    RealtimeStatisticsWorker.drain
  end
end
