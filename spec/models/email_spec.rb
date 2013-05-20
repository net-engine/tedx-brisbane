require 'spec_helper'

class EmailContent
end

describe Email do
  it { should belong_to(:attendee) }

  let(:email) { create(:email) }

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

  describe "#plain_text_content" do
    it "retreives content for the given event" do
      EmailContent.stub(:for)
      args = {attendee: email.attendee, event: email.event}
      EmailContent.should_receive(:for).with(args)

      email.plain_text_content
    end
  end
end
