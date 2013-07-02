require 'spec_helper'

describe AttendeesController do
  describe "POST create" do
    context "when providing proper parameters" do
      let(:attendee_params) do
        {
          first_name: "fn", last_name: "ln", email_address: "fn@ln.com.au"
        }
      end

      it "does create an attendee" do
        expect{
          post :create, attendee: attendee_params
        }.to change{Attendee.count}.by(1)
      end

      it "sets the flash properly" do
        post :create, attendee: attendee_params
        flash[:notice].should == "Thanks for registering!"
      end

      it "redirects to /" do
        post :create, attendee: attendee_params
        response.should redirect_to("/")
      end
    end

    context "when providing incorrect parameters" do
      let(:attendee_params) do
        {
          first_name: "fn", last_name: "ln", email_address: "bad_email"
        }
      end

      it "does not create an attendee" do
        expect{
          post :create, attendee: attendee_params
        }.to_not change{Attendee.count}.by(1)
      end

      it "sets the flash properly" do
        post :create, attendee: attendee_params
        flash[:error].should == "Email address is invalid"
      end

      # it "renders the proper template" do
      #   post :create, attendee: attendee_params
      #   response.should render_template("pages/index")
      # end
    end
  end
end