require 'spec_helper'

describe NullAttendee do
  let(:attendee) { NullAttendee.new }

  describe "#state" do
    it "returns 'invalid'" do
      attendee.state.should == "invalid"
    end
  end

  describe "#confirm!" do
    it "is a null-op" do
      attendee.confirm!.should == nil
    end
  end

  describe "#decline!" do
    it "is a null-op" do
      attendee.decline!.should == nil
    end
  end
end
