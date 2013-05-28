require 'spec_helper'
require 'sidekiq/testing'

describe InvitationRevokerWorker do
  context "given an attendee" do
    let!(:attendee) { create(:attendee) }

    it "responds to perform_in" do
      expect { InvitationRevokerWorker.perform_in(3.days, attendee.id) }.to_not raise_error
    end

  end

  context "given an attendee who has not accepted their invitation" do
    let!(:attendee) do
      a = create(:attendee)
      a.invite!
      a
    end

    it "succeeds in revoking the invitation" do
      InvitationRevokerWorker.perform_in(0.days, attendee.id)
      InvitationRevokerWorker.drain

      Attendee.find(attendee.id).state.should eq("awaiting_invitation")
    end

    it "creates an email for the attendee" do
      InvitationRevokerWorker.perform_in(0.days, attendee.id)
      InvitationRevokerWorker.drain

      Attendee.find(attendee.id).emails.count.should == 1
      Attendee.find(attendee.id).emails[0].event.should eq("revoke_invitation")
    end

    it "schedules that email for delivery" do
      InvitationRevokerWorker.perform_in(0.days, attendee.id)
      InvitationRevokerWorker.drain

      EmailDeliveryWorker.jobs.size.should == 1
    end
  end

  context "given the attendee has accepted the invitation" do
    let!(:attendee) do
      a = create(:attendee)
      a.invite!
      a.pay!
      a
    end

    it "attempts to revoke the invitaion" do
      Attendee.any_instance.stub(:revoke_invitation!)
      Attendee.any_instance.should_receive(:revoke_invitation!)

      InvitationRevokerWorker.perform_in(0.days, attendee.id)
      InvitationRevokerWorker.drain
    end

    it "fails to revoke the invitaion" do
      InvitationRevokerWorker.perform_in(0.days, attendee.id)
      InvitationRevokerWorker.drain

      Attendee.find(attendee.id).state.should eq("paid")
    end

    it "does not send the attendee an email" do
      InvitationRevokerWorker.perform_in(0.days, attendee.id)
      InvitationRevokerWorker.drain

      Attendee.find(attendee.id).emails.count.should == 0
    end
  end

end
