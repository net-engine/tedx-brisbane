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
    it "shows an empty for to create a new attendee" do
      visit '/'
      click_on "toggle-button"
      find_by_id('attendee_first_name').tag_name    == "input"
      find_by_id('attendee_first_name').value       == ""
      find_by_id('attendee_last_name').tag_name     == "input"
      find_by_id('attendee_last_name').value        == ""
      find_by_id('attendee_email_address').tag_name == "input"
      find_by_id('attendee_email_address').value    == ""
    end

    it "creates an attendee when submiting the form with proper value" do
      visit '/'
      expect do
        click_on "toggle-button"
        fill_in "attendee_first_name",    with: "Dan"
        fill_in "attendee_last_name",     with: "Sowter"
        fill_in "attendee_email_address", with: "dan@netengine.com.au"
        click_on "submit"
      end.to change{Attendee.count}.by(1)
    end
  end
end