require 'spec_helper'

describe "Viewing and email in the browser" do
  context "given an email" do
    let(:email) { create(:email) }

    it "renders the email" do
      expect { visit EmailLink.for(email) }.to_not raise_error
    end

    it "the content is identical to the delivered email" do
      visit EmailLink.for(email)
      page.body == email.html
    end
  end

  context "without an email" do
    it "redirects with a suitable message" do
      visit '/emails/123'

      current_path.should == "/"
      page.should have_content("Sorry, that doesn't appear to be a valid link.")
    end
  end
end
