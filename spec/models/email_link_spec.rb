require 'spec_helper'

describe EmailLink do
  before(:each) do
    HOSTNAME.test = 'http://www.example.com'
  end

  context "when initialized with an email" do
    let(:email) { build_stubbed(:email) }

    describe ".for" do
      it "returns the correct url" do
        email.stub(:token).and_return('ABC123')
        url = "http://www.example.com/emails/QUJDMTIz"

        EmailLink.for(email).should eq(url)
      end
    end
  end

  context "when initialized with an attendee" do
    let(:attendee) { build_stubbed(:attendee) }

    describe ".pay" do
      it "returns the correct url" do
        attendee.stub(:pay_token).and_return('ABC123')
        url = "http://www.example.com/pay/QUJDMTIz"

        EmailLink.pay(attendee).should eq(url)
      end

    end

    describe ".confirm" do
      it "returns the correct url" do
        attendee.stub(:confirm_token).and_return('ABC123')
        url = "http://www.example.com/confirm/QUJDMTIz"

        EmailLink.confirm(attendee).should eq(url)
      end
    end

    describe ".decline" do
      it "returns the correct url" do
        attendee.stub(:decline_token).and_return('ABC123')
        url = "http://www.example.com/decline/QUJDMTIz"

        EmailLink.decline(attendee).should eq(url)
      end
    end
  end
end
