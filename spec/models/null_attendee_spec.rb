require 'spec_helper'
include NullAttendee::Conversions

describe NullAttendee do
  let(:attendee) { NullAttendee.get }

  describe "#state" do
    it "returns 'invalid'" do
      attendee.state.should == 'invalid'
    end
  end

  describe "#confirm!" do
    it "is a null-op" do
      Actual(attendee.confirm!).should == Actual(NullAttendee.get)
    end
  end

  describe "#decline!" do
    it "is a null-op" do
      Actual(attendee.decline!).should == Actual(NullAttendee.get)
    end
  end

  describe "#emails" do
    it "is a null-op" do
      Actual(attendee.emails).should == Actual(NullAttendee.get)
    end
  end
end
