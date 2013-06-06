require 'spec_helper'

describe "Attendee statistics API" do
  let(:url) { statistics_api_v1_attendees_path }
  let(:body) { nil }

  context "passing the HTTP_AUTHORIZATION token" do
    let(:headers) { { 'HTTP_AUTHORIZATION' => 'Token token="abc123"', 'Accept' => 'application/json' } }

    it "returns a 200 :ok" do
      get url, body, headers

      response_body = %{
        {
          "attendee_statistics": {
            "received_invitation": 0,
            "awaiting_invitation": 0,
            "declined": 0,
            "paid": 0,
            "received_reminder": 0,
            "confirmed": 0
          }
        }
      }

      response.status.should == 200
      JSON.parse(response.body).should == JSON.parse(response_body)
    end

    context "given attendees in various states" do
      before(:each) do
        10.times do
          create(:attendee)
        end

        Attendee.last(8).map(&:invite!)
        Attendee.last(3).map(&:pay!)
        Attendee.last(2).map(&:remind!)
        Attendee.last(1).map(&:confirm!)
      end

      it "returns a 200 :ok" do
        get url, body, headers

        response_body = %{
          {
            "attendee_statistics": {
              "received_invitation": 5,
              "awaiting_invitation": 2,
              "declined": 0,
              "paid": 1,
              "received_reminder": 1,
              "confirmed": 1
            }
          }
        }

        response.status.should == 200
        JSON.parse(response.body).should == JSON.parse(response_body)
      end
    end
  end

  context "without passing the HTTP_AUTHORIZATION token" do
    let(:headers) { { 'Accept' => 'application/json' } }

    it "returns a 403 :unauthorized" do
      get url, body, headers

      response.status.should == 401
    end
  end
end
