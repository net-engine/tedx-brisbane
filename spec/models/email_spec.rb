require 'spec_helper'

describe Email do
  it { should belong_to(:attendee) }
  it { should validate_presence_of(:attendee) }
  it { should validate_presence_of(:event) }

  let(:attendee) { create(:attendee, email_address: "guy@example.com") }
  let(:email) { create(:email, attendee: attendee) }

  describe "#token" do
    before(:each) do
      Time.stub(:now).and_return Time.parse("2013-06-27T00:00:00+10:00")
    end

    it "is built on creation" do
      BCrypt::Password.new(email.token).should == "1372255200.0_guy@example.com"
    end
  end

  describe "#deliver" do
    it "creates an EmailDeliveryWorker" do
      EmailDeliveryWorker.stub(:perform_async)
      EmailDeliveryWorker.should_receive(:perform_async).with(email.id)

      email.deliver
    end
  end

  describe "#to_name" do
    it "retrieve name" do
      email.attendee.stub(:fullname)
      email.attendee.should_receive(:fullname)

      email.to_name
    end
  end

  describe "#to_address" do
    it "retrieve email address" do
      email.attendee.stub(:email_address)
      email.attendee.should_receive(:email_address)

      email.to_address
    end
  end

  describe "#html" do
    it "retreives content for the given event" do
      EmailContent.stub(:for)
      args = {attendee: email.attendee, email: email}
      EmailContent.should_receive(:for).with(args)

      email.html
    end
  end

  describe "#to_json" do
    it "returns the expected string" do
      EmailContent.stub(:for).and_return("stubbed html content goes here")

      json = %{
        {
          "key": "mandrill_key",
          "message": {
              "html": "stubbed html content goes here",
              "subject": "Message from TEDx",
              "from_email": "noreply@tedxbrisbane.com",
              "from_name": "TEDx Brisbane",
              "auto_text": true,
              "to": [
                  {
                      "email": "#{email.to_address}",
                      "name": "#{email.to_name}"
                  }
              ]
          }
        }
      }

      JSON.parse(email.to_json).should == JSON.parse(json)
    end
  end
end


