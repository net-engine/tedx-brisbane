require 'spec_helper'
require 'sidekiq/testing'

describe EmailDeliveryWorker do
  context "given an email" do
    let(:email) { create(:email) }

    describe ".perform_async" do
      it "responds to .perform_async" do
        expect { EmailDeliveryWorker.perform_async(email.id) }.to_not raise_error
      end

      it "calls the email deliverer with the email to be delivered" do
        EmailDeliverer.stub(:deliver)
        EmailDeliverer.should_receive(:deliver).with(email.id)

        EmailDeliveryWorker.perform_async(email.id)
        EmailDeliveryWorker.drain
      end
    end
  end
end
