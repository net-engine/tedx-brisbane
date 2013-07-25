require 'spec_helper'

describe "The payment page", js: true do
  context "given an invited attendee" do
    let(:attendee) do
      create(:attendee).tap do |a|
        a.invite!
      end
    end
    let(:url) { new_payment_path(Base64.urlsafe_encode64(attendee.pay_token)) }
    let(:cc) { OpenStruct.new(number: '4111111111111111', expiry: '01/2020', cvv: '123') }

    it "doesn't redirect away from payments" do
      visit(url)
      current_path.should == url
    end

    it "builds an adequate payment form", js: false do
      visit(url)

      find("form")[:action].should match("https://sandbox.braintreegateway.com:443/")
      find_by_id("tr_data").value.should match("redirect_url=http%3A%2F%2Fwww.example.com%2Fpayments%2Fconfirm")
      find_by_id("tr_data").value.should match("submit_for_settlement%5D=true")
      find_by_id("tr_data").value.should match("attendee_pay_token")
      find_by_id("tr_data").value.should match("customer%5D%5Bemail%5D=")
      find_by_id("transaction_customer_first_name").value.should == attendee.first_name
      find_by_id("transaction_customer_last_name").value.should == attendee.last_name
      page.should have_content(attendee.email_address)
    end

    context "when submitting the form with a valid credit card" do
      it "succeeds" do
        visit(url)
        fill_in "transaction_customer_first_name", with: 'Douglas'
        fill_in "transaction_customer_last_name", with: 'Adams'
        fill_in "transaction_credit_card_number", with: cc.number
        fill_in "transaction_credit_card_expiration_date", with: cc.expiry
        fill_in "transaction_credit_card_cvv", with: cc.cvv
        click_on "Submit"

        page.should have_content("Thank you, your payment was successful.")
        attendee.reload
        attendee.payments.count.should == 1
        attendee.first_name.should == "Douglas"
        attendee.last_name.should == "Adams"
        attendee.state.should == "paid"
        attendee.student.should == false
        EmailDeliveryWorker.jobs.size.should == 1
      end
    end

    context "when submitting the form with a valid credit card while being a student" do
      it "succeeds" do
        visit(url)
        select("$#{TICKET.price_in_dollars_for_student} for students", :from => 'student_amount')
        fill_in "transaction_customer_first_name", with: 'Douglas'
        fill_in "transaction_customer_last_name", with: 'Adams'
        fill_in "transaction_credit_card_number", with: cc.number
        fill_in "transaction_credit_card_expiration_date", with: cc.expiry
        fill_in "transaction_credit_card_cvv", with: cc.cvv
        click_on "Submit"

        page.should have_content("Thank you, your payment was successful.")
        attendee.reload
        attendee.payments.count.should == 1
        attendee.first_name.should == "Douglas"
        attendee.last_name.should == "Adams"
        attendee.state.should == "paid"
        attendee.student.should == true
        EmailDeliveryWorker.jobs.size.should == 1
      end
    end

    context "when submitting the form with an invalid credit card" do
      before(:each) do
        TICKET.stub(:price_in_dollars).and_return(2999)
      end

      it "fails" do
        visit(url)
        fill_in "transaction_customer_first_name", with: 'Douglas'
        fill_in "transaction_customer_last_name", with: 'Adams'
        fill_in "transaction_credit_card_number", with: cc.number
        fill_in "transaction_credit_card_expiration_date", with: cc.expiry
        fill_in "transaction_credit_card_cvv", with: cc.cvv
        click_on "Submit"

        page.should have_content("Sorry, your payment was declined.")
        attendee.reload
        attendee.payments.count.should == 0
        attendee.first_name.should_not == "Douglas"
        attendee.last_name.should_not == "Adams"
        attendee.state.should_not == "paid"
        EmailDeliveryWorker.jobs.size.should == 0
      end
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
