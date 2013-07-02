require 'spec_helper'

describe "The dashboard", js: true do
  context "without attendees" do
    it "shows attendee statistics" do
      visit '/'

      within "#received_invitation" do
        page.should have_content('0')
      end

      within "#awaiting_invitation" do
        page.should have_content('0')
      end

      within "#declined" do
        page.should have_content('0')
      end

      within "#paid" do
        page.should have_content('0')
      end

      within "#received_reminder" do
        page.should have_content('0')
      end

      within "#confirmed" do
        page.should have_content('0')
      end
    end
  end

  context "with attendees in various states" do
    before(:each) do
      create_attendees_in_various_states
    end

    it "shows attendee statistics" do
      visit '/'

      within "#received_invitation" do
        page.should have_content('5')
      end

      within "#awaiting_invitation" do
        page.should have_content('2')
      end

      within "#declined" do
        page.should have_content('0')
      end

      within "#paid" do
        page.should have_content('1')
      end

      within "#received_reminder" do
        page.should have_content('1')
      end

      within "#confirmed" do
        page.should have_content('1')
      end
    end
  end

  context "when visiting the main page" do
    it "shows an empty form to create a new attendee" do
      visit '/'
      find_by_id('attendee_first_name').tag_name    == "input"
      find_by_id('attendee_first_name').value       == ""
      find_by_id('attendee_last_name').tag_name     == "input"
      find_by_id('attendee_last_name').value        == ""
      find_by_id('attendee_email_address').tag_name == "input"
      find_by_id('attendee_email_address').value    == ""
    end

    context "when submiting the form with proper value" do
      before(:each) do
        create(:admin_user)

        visit '/'
        fill_in "attendee_first_name",    with: "Dan"
        fill_in "attendee_last_name",     with: "Sowter"
        fill_in "attendee_email_address", with: "dan@netengine.com.au"
        click_on "submit"
      end

      it "creates an attendee when submiting the form with proper value" do
        sign_in_as_admin

        within "#attendee_1" do
          find(".first_name").should have_content("Dan")
          find(".last_name").should have_content("Sowter")
          find(".email_address").should have_content("dan@netengine.com.au")
        end
      end

      it "sends a registration email" do
        sign_in_as_admin
        visit('/admin/emails')

        page.should have_content("dan@netengine.com.au")
      end
    end
  end
end
