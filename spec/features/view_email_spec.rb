require 'spec_helper'

describe "Viewing and email in the browser" do
  let(:email) { create(:email) }

  it "renders the email" do
    visit email_path(email)
  end
end
