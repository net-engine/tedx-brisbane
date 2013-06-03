require 'spec_helper'

describe "The payment page" do
  context "given an invited attendee" do
    let(:attendee) do
      create(:attendee).tap do |a|
        a.invite!
      end
    end
    let(:url) { new_payment_path(Base64.urlsafe_encode64(attendee.pay_token)) }

    it "doesn't redirect away from payments" do
      visit(url)
      current_path.should == url
    end

    it "builds an adequate payment form" do
      visit(url)

      find("form")[:action].should match("https://sandbox.braintreegateway.com:443/")
      find("#tr_data").value.should match("redirect_url=http%3A%2F%2Fwww.example.com%2Fpayments%2Fconfirm")
      find("#tr_data").value.should match("submit_for_settlement%5D=true")
      page.should have_content(attendee.email_address)
    end

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
    it "redirects home" do
      visit(new_payment_path('abc'))
      current_path.should == '/'
    end

    it "displays an error message" do
      visit(new_payment_path('abc'))
      page.should have_content("Sorry, that doesn't appear to be a valid link.")
    end
  end
end
