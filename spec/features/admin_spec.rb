require 'spec_helper'

describe "The admin interface", js: true do
  before(:each) do
    create(:admin_user)
    sign_in_as_admin
  end

  it "allows sign in" do
    current_path.should == '/admin'
    page.should have_content('Dashboard')
  end

  context "batch editing on the attendees page" do
    let!(:attendee) { create(:attendee) }

    it "allow batch edit deletion" do
      visit '/admin/attendees'

      page.should have_content("Attendees")
      check 'collection_selection_toggle_all'
      click_on 'Batch Actions'
      click_on 'Delete Selected'

      page.should have_content("Successfully destroyed 1 attendee")
      Attendee.count.should == 0
    end
  end
end
