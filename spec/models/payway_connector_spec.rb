require 'spec_helper'

describe PaywayConnector do
  describe "#initialize" do
    let(:attendee){ create(:attendee) }
    let(:valid_transaction_params) do
      {
        transaction: {
          customer: {
            first_name: "firstname",
            last_name: "lastname"
          },
          credit_card:
            {
              type: "master",
              number: "1234567890",
              expiration_date: "12/13",
              cvv: "123"
            }
        },
        student_amount: false
      }
    end

    it "should raise an Exceptions::InvalidAttendee if the attendee has not the proper state" do
      attendee.state.should == "awaiting_invitation"
      expect { PaywayConnector.new(attendee, valid_transaction_params) }.to raise_error(Exceptions::InvalidAttendee)
    end

    it "should not raise an Exceptions::InvalidAttendee if the attendee has not the proper state" do
      attendee.invite!
      expect { PaywayConnector.new(attendee, valid_transaction_params) }.to_not raise_error(Exceptions::InvalidAttendee)
    end

    it "should raise an Exceptions::MissingCCField if some parameters are missing" do
      attendee.invite!
      expect { PaywayConnector.new(attendee, {}) }.to raise_error(Exceptions::MissingCCField)
      # removing only the fist_name
      valid_transaction_params[:transaction][:customer].delete(:first_name)
      expect { PaywayConnector.new(attendee, valid_transaction_params) }.to raise_error(Exceptions::MissingCCField)
    end

    it "should raise an Exceptions::UnsupportedCCBrand if the card brand is not master or visa" do
      attendee.invite!
      # removing only the fist_name
      valid_transaction_params[:transaction][:credit_card][:type] = "bad_brand"
      expect { PaywayConnector.new(attendee, valid_transaction_params) }.to raise_error(Exceptions::UnsupportedCCBrand)
    end

    it "should set the proper instance variables when the provided data is correct" do
      attendee.invite!
      pc = PaywayConnector.new(attendee, valid_transaction_params)
      pc.instance_variable_get(:@attendee).should   == attendee
      pc.instance_variable_get(:@amount).should     == TICKET.price_in_dollars
      pc.instance_variable_get(:@cc_details).should == {
        number:              1234567890,
        month:               12,
        year:                13,
        first_name:          "firstname",
        last_name:           "lastname",
        verification_value:  123,
        brand:               "master"
      }
      pc.instance_variable_get(:@options).should == {
        order_number: attendee.pay_token
      }
    end
  end
end