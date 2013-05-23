require 'spec_helper'

describe EmailContent do
  let(:attendee) { build_stubbed(:attendee, email_address: 'jane@example.com') }

  describe ".for" do
    let(:event) { "invite" }

    it "accepts a hash with keys attendee and event" do
      expect {
        EmailContent.for attendee: attendee, event: event
        }.to_not raise_error
    end

    it "raises an error if attendee is not in arguments" do
      expect {
        EmailContent.for event: event
        }.to raise_error(ArgumentError)
    end

    it "raises an error if event is not in arguments" do
      expect {
        EmailContent.for attendee: attendee
        }.to raise_error(ArgumentError)
    end

    it "returns a string" do
      EmailContent.for(attendee: attendee, event: event).should be_a_kind_of(String)
    end

    it "creates an instance of EmailContent" do
      email = double("email").as_null_object

      EmailContent.stub(:new).and_return(email)
      EmailContent.should_receive(:new)

      EmailContent.for attendee: attendee, event: event
    end
  end

  describe "#content" do
    context "when given an Attendee with email_address 'jane@example.com'" do
      context "when the event is 'invite'" do
        it "returns the expected text" do
          text = EmailContent.new(attendee: attendee, event: "invite").content

          text.should == "Hi, jane@example.com. You've been invited!!"
        end
      end

      context "when the event is 'revoke_invitation'" do
        it "returns the expected text" do
          text = EmailContent.new(attendee: attendee, event: "revoke_invitation").content

          text.should == "Sorry, jane@example.com. You took too long, so your invitation has been revoked. Better luck next time!!"
        end
      end

      context "when the event is 'something_else'" do
        it "returns the expected text" do
          text = EmailContent.new(attendee: attendee, event: "something_else").content

          text.should == "Sorry, jane@example.com. I don't know why I'm emailing you."
        end
      end

    end
  end
end

