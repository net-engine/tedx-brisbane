require 'spec_helper'

describe EmailContent do
  let(:attendee) { create(:attendee, email_address: 'dan@netengine.com.au') }

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
    context "when given an Attendee with email_address 'dan@netengine.com.au'" do
      context "when the event is 'register'" do
        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, event: "register").content
          }.to_not raise_error
        end

        it "contains the decline link" do
          html = EmailContent.new(attendee: attendee, event: "register").content
          html.should match(EmailLink.decline(attendee))
        end
      end

      context "when the event is 'invite'" do
        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, event: "invite").content
          }.to_not raise_error
        end

        it "contains the pay link" do
          html = EmailContent.new(attendee: attendee, event: "invite").content
          html.should match(EmailLink.pay(attendee))
        end

        it "contains the decline link" do
          html = EmailContent.new(attendee: attendee, event: "invite").content
          html.should match(EmailLink.decline(attendee))
        end
      end

      context "when the event is 'provide_complimentary_ticket'" do
        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, event: "provide_complimentary_ticket").content
          }.to_not raise_error
        end

        it "contains the decline link" do
          html = EmailContent.new(attendee: attendee, event: "provide_complimentary_ticket").content
          html.should match(EmailLink.decline(attendee))
        end
      end

      context "when the event is 'revoke_invitation'" do
        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, event: "revoke_invitation").content
          }.to_not raise_error
        end

        it "contains the decline link" do
          html = EmailContent.new(attendee: attendee, event: "revoke_invitation").content
          html.should match(EmailLink.decline(attendee))
        end
      end

      context "when the event is 'pay'" do
        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, event: "pay").content
          }.to_not raise_error
        end
      end

      context "when the event is 'decline'" do
        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, event: "decline").content
          }.to_not raise_error
        end
      end

      context "when the event is 'remind'" do
        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, event: "remind").content
          }.to_not raise_error
        end

        it "contains the confirm link" do
          html = EmailContent.new(attendee: attendee, event: "remind").content
          html.should match(EmailLink.confirm(attendee))
        end
      end

      context "when the event is 'confirm'" do
        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, event: "confirm").content
          }.to_not raise_error
        end
      end

      context "when the event is 'something_else'" do
        it "raises an exception" do
          expect {
            EmailContent.new(attendee: attendee, event: "something_else").content
          }.to raise_error(Exceptions::EmailEventNotRecognised)
        end
      end
    end
  end
end

