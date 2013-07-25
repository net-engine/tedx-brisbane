require 'spec_helper'

describe "Creating a new attendee via the API" do
  let(:url) { '/api/v1/attendees' }
  let(:body) {
    %{
      {
        "attendees": [
          {
            "email_address": "example@testingguy.com",
            "hidden_horrible_param": "doug",
            "first_name": "example",
            "last_name":  "testingguy",
            "gender": "M",
            "age":  32,
            "profession":  "Architect",
            "tweet_idea":  "Heal the world. Make it a better place."
          },
          {
            "email_address": "otherguy@testing.com",
            "hidden_horrible_param": "doug",
            "first_name": "otherguy",
            "last_name":  "testing",
            "gender": "M",
            "age":  32,
            "profession":  "Architect",
            "tweet_idea":  "Heal the world. Make it a better place."
          }
        ]
      }
    }
  }

  context "passing the HTTP_AUTHORIZATION token" do
    let(:headers) { { 'HTTP_AUTHORIZATION' => 'Token token="abc123"', 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

    context "with properly formed JSON" do
      it "returns a 201 :created" do
        post url, body, headers

        response_body = %{
          {
            "attendees": [
              {
                "id": #{Attendee.where(email_address: "example@testingguy.com").first.try(:id)},
                "email_address": "example@testingguy.com",
                "state": "awaiting_invitation",
                "round": 1,
                "first_name": "example",
                "last_name": "testingguy",
                "gender": "M",
                "age":  32,
                "profession":  "Architect",
                "tweet_idea":  "Heal the world. Make it a better place.",
                "scholarship": false
              },
              {
                "id": #{Attendee.where(email_address: "otherguy@testing.com").first.try(:id) || 0},
                "email_address": "otherguy@testing.com",
                "state": "awaiting_invitation",
                "round": 1,
                "first_name": "otherguy",
                "last_name":  "testing",
                "gender": "M",
                "age":  32,
                "profession":  "Architect",
                "tweet_idea":  "Heal the world. Make it a better place.",
                "scholarship": false
              }
            ]
          }
        }

        response.status.should == 201
        JSON.parse(response.body).should == JSON.parse(response_body)
      end
    end

    context "with improperly formed JSON" do
      it "returns a helpful message for poorly formed JSON" do
        Api::V1::AttendeesController.any_instance.stub(:create).and_raise(MultiJson::LoadError)
        post url, body, headers

        response_body = { error: :malformed_json, message: "You have provided malformed json" }.to_json

        JSON.parse(response.body).should == JSON.parse(response_body)
      end
    end
  end

  context "without passing the HTTP_AUTHORIZATION token" do
    let(:headers) { { 'Accept' => 'application/json' } }

    it "returns a 401 :unauthorized" do
      post url, body, headers

      response.status.should == 401
    end
  end
end
