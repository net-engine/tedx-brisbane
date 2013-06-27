require 'spec_helper'

describe Attendee do
  let(:attendee) { create(:attendee, email_address: "jane@example.com") }

  it { should validate_presence_of(:email_address) }
  it { should validate_uniqueness_of(:email_address) }
  it { should validate_uniqueness_of(:pay_token) }
  it { should validate_uniqueness_of(:decline_token) }
  it { should validate_uniqueness_of(:confirm_token) }
  it { should have_many(:emails).dependent(:destroy) }
  it { should have_many(:payments).dependent(:destroy) }

  it "should reject invalid email addresses" do
    attendee = build(:attendee, email_address: "doug")
    attendee.should_not be_valid
  end

  describe ".statistics" do
    it "returns an OpenStruct" do
      Attendee.statistics.should be_a_kind_of(OpenStruct)
    end

    context "when there are attendees in various states" do
      before(:each) do
        create_attendees_in_various_states
      end

      it "returns the count of attendees in each state" do
        Attendee.statistics.received_reminder.should == 1
        Attendee.statistics.awaiting_invitation.should == 2
        Attendee.statistics.paid.should == 1
        Attendee.statistics.confirmed.should == 1
        Attendee.statistics.received_invitation.should == 5
      end
    end

    context "when there are no attendees" do
      it "doesn't raise an error querying each state" do
        expect {
          Attendee.statistics.received_invitation
        }.to_not raise_error
      end
    end
  end

  describe "#pay_token" do
    it "is built on creation" do
      BCrypt::Password.new(attendee.pay_token).should == "jane@example.com-pay"
    end
  end

  describe "#confirm_token" do
    it "is built on creation" do
      BCrypt::Password.new(attendee.confirm_token).should == "jane@example.com-confirm"
    end
  end

  describe "#decline_token" do
    it "is built on creation" do
      BCrypt::Password.new(attendee.decline_token).should == "jane@example.com-decline"
    end
  end

  describe "round" do
    it "defaults to 1" do
      attendee.round.should == 1
    end
  end

  describe "#increment_round!" do
    it "increments the round number" do
      attendee.increment_round!
      attendee.round.should == 2
    end
  end

  describe "#fullname" do
    it "returns a string" do
      attendee.fullname.should == attendee.email_address
    end
  end


  describe "states" do
    context "when the Attendee is created" do
      it "starts in state 'awaiting_invitation'" do
        attendee.state.should == 'awaiting_invitation'
      end

      it "starts in the first round of invites" do
        attendee.round.should == 1
      end

      describe "#invite!" do
        it "transitions the state to received_invitation" do
          attendee.invite!
          attendee.state.should == 'received_invitation'
        end

        it "doesn't increment the round" do
          attendee.invite!
          attendee.round.should == 1
        end
      end

      describe "#revoke_invitation!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.revoke_invitation!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#provide_complimentary_ticket!" do
        it "sets the state to received_complimentary_ticket" do
          attendee.provide_complimentary_ticket!
          attendee.state.should == 'received_complimentary_ticket'
        end
      end

      describe "#pay!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.pay!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#decline!" do
        it " set the state to decline" do
          attendee.decline!
          attendee.state.should == 'declined'
        end
      end

      describe "#confirm!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.confirm!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#remind!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.remind!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end
    end

    context "when the Attendee is invited" do
      before(:each) do
        attendee.invite!
      end

      describe "#invite!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.invite!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#provide_complimentary_ticket!" do
        it "sets the state to received_complimentary_ticket" do
          attendee.provide_complimentary_ticket!
          attendee.state.should == 'received_complimentary_ticket'
        end
      end

      describe "#revoke_invitation!" do
        it "returns the attendee to the awaiting_invitation state" do
          attendee.revoke_invitation!
          attendee.state.should == 'awaiting_invitation'
        end

        it "increments the round" do
          attendee.revoke_invitation!
          attendee.round.should == 2
        end
      end

      describe "#pay!" do
        it "promotes the attendee to the paid state" do
          attendee.pay!
          attendee.state.should == 'paid'
        end
      end

      describe "#decline!" do
        it "promotes the attendee to the declined state" do
          attendee.decline!
          attendee.state.should == 'declined'
        end
      end

      describe "#confirm!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.confirm!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#remind!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.remind!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end
    end

    context "when the Attendee has paid" do
      before(:each) do
        attendee.invite!
        attendee.pay!
      end

      describe "#invite!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.invite!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#provide_complimentary_ticket!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.provide_complimentary_ticket!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#revoke_invitation!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.revoke_invitation!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#pay!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.pay!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#decline!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.decline!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#confirm!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.confirm!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#remind!" do
        it "promotes the attendee to the received_reminder state" do
          attendee.remind!
          attendee.state.should == 'received_reminder'
        end
      end
    end

    context "when the Attendee has received_complimentary_ticket" do
      before(:each) do
        attendee.provide_complimentary_ticket!
      end

      describe "#invite!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.invite!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#provide_complimentary_ticket!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.provide_complimentary_ticket!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#revoke_invitation!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.revoke_invitation!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#pay!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.pay!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#decline!" do
        it "promotes the attendee to the declined state" do
          attendee.decline!
          attendee.state.should == 'declined'
        end
      end

      describe "#confirm!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.confirm!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#remind!" do
        it "promotes the attendee to the received_reminder state" do
          attendee.remind!
          attendee.state.should == 'received_reminder'
        end
      end
    end

    context "when the Attendee has confirmed" do
      before(:each) do
        attendee.invite!
        attendee.pay!
        attendee.remind!
        attendee.confirm!
      end

      describe "#invite!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.invite!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#revoke_invitation!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.revoke_invitation!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#provide_complimentary_ticket!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.provide_complimentary_ticket!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#pay!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.pay!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#decline!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.decline!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#confirm!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.confirm!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#remind!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.remind!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end
    end

    context "when the Attendee has been reminded" do
      before(:each) do
        attendee.invite!
        attendee.pay!
        attendee.remind!
      end

      describe "#provide_complimentary_ticket!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.provide_complimentary_ticket!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#remind!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.remind!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#invite!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.invite!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#revoke_invitation!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.revoke_invitation!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#pay!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.pay!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#decline!" do
        it "raises an error (invalid transition)" do
          expect {
            attendee.decline!
          }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      describe "#confirm!" do
        it "promotes the attendee to the confirmed state" do
          attendee.confirm!
          attendee.state.should == 'confirmed'
        end
      end
    end
  end
end
