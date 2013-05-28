require 'spec_helper'

describe EmailLink do
  context "when initialized with an attendee" do
    let(:attendee) { build_stubbed(:attendee) }

    describe ".pay" do
      it "returns the correct url" do
        attendee.stub(:pay_token).and_return('ABC123')
        url = 'https://www.example.com/pay/ABC123'

        EmailLink.pay(attendee).should eq(url)
      end

    end

    describe ".confirm" do
      it "returns the correct url" do
        attendee.stub(:confirm_token).and_return('ABC123')
        url = 'https://www.example.com/confirm/ABC123'

        EmailLink.confirm(attendee).should eq(url)
      end
    end

    describe ".decline" do
      it "returns the correct url" do
        attendee.stub(:decline_token).and_return('ABC123')
        url = 'https://www.example.com/decline/ABC123'

        EmailLink.decline(attendee).should eq(url)
      end
    end
  end
end
