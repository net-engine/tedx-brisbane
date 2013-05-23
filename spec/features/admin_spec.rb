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

  it "shows existing admin users" do
    visit '/admin/admin_users'
  end

  it "allows creation of new attendees" do
    visit '/admin/attendees/new'

    fill_in 'attendee_email_address', with: 'some_guy@example.com'
    click_on 'Create Attendee'

    page.should have_content("Attendee was successfully created")
    Attendee.last.email_address.should == 'some_guy@example.com'
  end

  it "allows creation of new admin users" do
    visit '/admin/admin_users/new'

    fill_in 'admin_user_email', with: 'some_new_admin@example.com'
    fill_in 'admin_user_password', with: 'something123'
    fill_in 'admin_user_password_confirmation', with: 'something123'
    click_on 'Create Admin user'

    page.should have_content("Admin user was successfully created")
    AdminUser.last.email.should == 'some_new_admin@example.com'
  end

  context "batch editing on the attendees page" do
    let!(:attendee) { create(:attendee) }

    before(:each) do
      visit '/admin/attendees'

      page.should have_content("Attendees")
      check 'collection_selection_toggle_all'
      click_on 'Batch Actions'
    end

    it "allows batch edit deletion" do
      click_on 'Delete Selected'

      page.should have_content("Successfully destroyed 1 attendee")
      Attendee.count.should == 0
    end

    it "allows batch edit inviting" do
      click_on 'Invite Selected'

      page.should have_content("Successfully invited 1 attendee")
      Attendee.where(state: 'received_invitation').count.should == 1
      EmailDeliveryWorker.jobs.size.should == 1
    end

    it "doesn't fail on impossible state transitions" do
      attendee.invite!
      click_on 'Invite Selected'

      page.should have_content("Successfully invited 1 attendee")
      EmailDeliveryWorker.jobs.size.should == 0
    end
  end
end
