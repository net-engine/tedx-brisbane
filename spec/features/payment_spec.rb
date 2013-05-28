require 'spec_helper'

describe "The payment page" do
  context "given an invited attendee" do
    let(:attendee) do
      create(:attendee).tap do |a|
        a.invite!
      end
    end

    it "doesn't redirect away from payments" do
      visit payment_path(attendee)
      current_path.should == payment_path(attendee)
    end

    it "shows the payment form"

    context "when submitting the form with a valid credit card" do
      it "shows a success message"
      it "creates a record of the payment"
      it "adds the name information to the attendee"
      it "promotes the attendee to 'paid'"
    end

    context "when submitting the form with an invalid credit card" do
      it "shows a failure message"
      it "doesn't create a record of the payment"
      it "doesn't promote the attenee to 'paid'"
    end
  end

  context "without an invited attendee" do
    it "redirects home"
    it "displays an error message"
  end
end
