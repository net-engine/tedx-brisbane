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
end
