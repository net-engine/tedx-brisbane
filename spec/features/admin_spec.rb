require 'spec_helper'

describe "The admin interface", js: true do
  before(:each) do
    create(:admin_user)
    sign_in_as_admin
  end

  it "allows sign in" do
    current_path.should == '/admin'
    page.should have_content('Attendees')
  end

  it "shows existing admin users" do
    visit '/admin/admin_users'
  end

  context "emails" do
    let!(:email) { create(:email) }

    it "shows links to allow browsing of emails" do
      visit '/admin/emails'

      page.body.should match(EmailLink.for(email))
    end
  end

  it "allows creation of new attendees" do
    visit '/admin/attendees/new'

    fill_in 'attendee_first_name',    with: 'some'
    fill_in 'attendee_last_name',     with: 'guy'
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

    context "when inviting" do
      it "allows batch edit inviting" do
        click_on 'Invite Selected'

        page.should have_content("Successfully invited 1 attendees")
        Attendee.where(state: 'received_invitation').count.should == 1
        EmailDeliveryWorker.jobs.size.should == 1
        InvitationRevokerWorker.jobs.size.should == 1
      end

      it "schedules the invitaion to be revoked in 5 days" do
        InvitationRevokerWorker.stub(:perform_in)
        InvitationRevokerWorker.should_receive(:perform_in).with(5.days, attendee.id)

        click_on 'Invite Selected'
      end

      it "doesn't fail on impossible state transitions" do
        attendee.invite!
        click_on 'Invite Selected'

        page.should have_content("Successfully invited 1 attendees")
        EmailDeliveryWorker.jobs.size.should == 0
        InvitationRevokerWorker.jobs.size.should == 0
      end
    end

    context "when reminding" do
      before(:each) do
        attendee.invite!
        attendee.pay!
      end

      it "allows batch edit reminding" do
        click_on 'Remind Selected'

        page.should have_content("Successfully reminded 1 attendees")
        Attendee.where(state: 'received_reminder').count.should == 1
        EmailDeliveryWorker.jobs.size.should == 1
      end

      it "doesn't fail on impossible state transitions" do
        attendee.remind!
        click_on 'Remind Selected'

        page.should have_content("Successfully reminded 1 attendees")
        EmailDeliveryWorker.jobs.size.should == 0
      end
    end

    context "when confirming" do
      before(:each) do
        attendee.invite!
        attendee.pay!
        attendee.remind!
      end

      it "allows batch edit confirming" do
        click_on 'Confirm Selected'

        page.should have_content("Successfully confirmed 1 attendees")
        Attendee.where(state: 'confirmed').count.should == 1
        EmailDeliveryWorker.jobs.size.should == 1
      end

      it "doesn't fail on impossible state transitions" do
        attendee.confirm!
        click_on 'Confirm Selected'

        page.should have_content("Successfully confirmed 1 attendees")
        EmailDeliveryWorker.jobs.size.should == 0
      end
    end

    context "when declining" do
      before(:each) do
        attendee.invite!
      end

      it "allows batch edit declining" do
        click_on 'Decline Selected'

        page.should have_content("Successfully declined 1 attendees")
        Attendee.where(state: 'declined').count.should == 1
        EmailDeliveryWorker.jobs.size.should == 1
      end

      it "doesn't fail on impossible state transitions" do
        attendee.decline!
        click_on 'Decline Selected'

        page.should have_content("Successfully declined 1 attendees")
        EmailDeliveryWorker.jobs.size.should == 0
      end
    end

    context "when revoking invitations" do
      before(:each) do
        attendee.invite!
      end

      it "allows batch edit revoking" do
        click_on 'Uninvite Selected'

        page.should have_content("Successfully revoked invitations for 1 attendees")
        Attendee.where(state: 'awaiting_invitation').count.should == 1
        EmailDeliveryWorker.jobs.size.should == 1
      end

      it "doesn't fail on impossible state transitions" do
        attendee.revoke_invitation!
        click_on 'Uninvite Selected'

        page.should have_content("Successfully revoked invitations for 1 attendees")
        EmailDeliveryWorker.jobs.size.should == 0
      end
    end

    context "when giving away free tickets" do
      it "allows batch edit giving of free tickets" do
        click_on 'Gift Selected'

        page.should have_content("Successfully provided complimentary tickets for 1 attendees")
        Attendee.where(state: 'received_complimentary_ticket').count.should == 1
        EmailDeliveryWorker.jobs.size.should == 1
      end

      it "doesn't fail on impossible state transitions" do
        attendee.provide_complimentary_ticket!
        click_on 'Gift Selected'

        page.should have_content("Successfully provided complimentary tickets for 1 attendees")
        EmailDeliveryWorker.jobs.size.should == 0
      end
    end
  end
end
