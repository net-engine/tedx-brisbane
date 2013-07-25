require 'spec_helper'

describe EmailContent do
  let(:attendee) { create(:attendee, email_address: 'dan@netengine.com.au') }
  let(:event) { 'invite' }
  let(:email) { create(:email, attendee: attendee, event: event) }

  describe ".for" do
    it "accepts a hash with keys attendee and email" do
      expect {
        EmailContent.for attendee: attendee, email: email
        }.to_not raise_error
    end

    it "raises an error if attendee is not in arguments" do
      expect {
        EmailContent.for email: email
        }.to raise_error(ArgumentError)
    end

    it "raises an error if email is not in arguments" do
      expect {
        EmailContent.for attendee: attendee
        }.to raise_error(ArgumentError)
    end

    it "returns a string" do
      EmailContent.for(attendee: attendee, email: email).should be_a_kind_of(String)
    end

    it "creates an instance of EmailContent" do
      email = double("email").as_null_object

      EmailContent.stub(:new).and_return(email)
      EmailContent.should_receive(:new)

      EmailContent.for attendee: attendee, email: email
    end
  end

  describe "#content" do
    context "when given an Attendee with email_address 'dan@netengine.com.au'" do
      context "when the event is 'register'" do
        let(:event) { 'register' }

        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, email: email).content
          }.to_not raise_error
        end

        it "contains the decline link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.decline(attendee))
        end

        it "contains the 'view this in a browser' link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.for(email))
        end
      end

      context "when the event is 'invite'" do
        let(:event) { 'invite' }

        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, email: email).content
          }.to_not raise_error
        end

        it "contains the pay link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.pay(attendee))
        end

        it "contains the decline link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.decline(attendee))
        end

        it "contains the 'view this in a browser' link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.for(email))
        end
      end

      context "when the event is 'provide_complimentary_ticket'" do
        let(:event) { 'provide_complimentary_ticket' }

        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, email: email).content
          }.to_not raise_error
        end

        it "contains the decline link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.decline(attendee))
        end

        it "contains the 'view this in a browser' link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.for(email))
        end
      end

      context "when the event is 'revoke_invitation'" do
        let(:event) { 'revoke_invitation' }

        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, email: email).content
          }.to_not raise_error
        end

        it "contains the 'view this in a browser' link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.for(email))
        end
      end

      context "when the event is 'pay'" do
        let(:event) { 'pay' }

        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, email: email).content
          }.to_not raise_error
        end

        it "contains the 'view this in a browser' link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.for(email))
        end
      end

      context "when the event is 'decline'" do
        let(:event) { 'decline' }

        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, email: email).content
          }.to_not raise_error
        end

        it "contains the 'view this in a browser' link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.for(email))
        end
      end

      context "when the event is 'decline'" do
        let(:event) { 'decline_from_user' }

        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, email: email).content
          }.to_not raise_error
        end

        it "contains the 'view this in a browser' link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.for(email))
        end
      end

      context "when the event is 'remind'" do
        let(:event) { 'remind' }

        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, email: email).content
          }.to_not raise_error
        end

        it "contains the confirm link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.confirm(attendee))
        end

        it "contains the 'view this in a browser' link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.for(email))
        end
      end

      context "when the event is 'confirm'" do
        let(:event) { 'confirm' }

        it "returns html" do
          expect {
            EmailContent.new(attendee: attendee, email: email).content
          }.to_not raise_error
        end

        it "contains the 'view this in a browser' link" do
          html = EmailContent.new(attendee: attendee, email: email).content
          html.should match(EmailLink.for(email))
        end
      end

      context "when the event is 'something_else'" do
        let(:event) { 'something_else' }

        it "raises an exception" do
          expect {
            EmailContent.new(attendee: attendee, email: email).content
          }.to raise_error(Exceptions::EmailEventNotRecognised)
        end
      end
    end
  end
end

