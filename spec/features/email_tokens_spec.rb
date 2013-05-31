require 'spec_helper'

describe "Receiving links in emails" do
  let(:attendee) { create(:attendee) }


  describe "the pay link" do
    let(:url) { EmailLink.pay(attendee) }

    it "displays a reasonable error message for invalid tokens" do
      visit("/pay/abc")
      page.should have_content("Sorry, that doesn't appear to be a valid link.")
    end

    context "when the invitation is still valid" do
      before(:each) do
        attendee.invite!
      end

      it "redirects to the payment page" do
        pending
        current_path.should == new_payment_path(attendee)
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end

    context "when the invitation has been revoked" do
      before(:each) do
        attendee.invite!
        attendee.revoke_invitation!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message explaining that the invitation timed out" do
        visit(url)
        page.should have_content("Sorry, you didn't purchase your ticket in time. You have been returned to the queue.")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end

    context "when the attendee has already paid" do
      before(:each) do
        attendee.invite!
        attendee.pay!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message explaining that payment has already been accepted" do
        visit(url)
        page.should have_content("You've already paid.")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end

    context "when the attendee has already been reminded" do
      before(:each) do
        attendee.invite!
        attendee.pay!
        attendee.remind!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message explaining that payment has already been accepted" do
        visit(url)
        page.should have_content("You've already paid.")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end

    context "when the attendee has already confirmed" do
      before(:each) do
        attendee.invite!
        attendee.pay!
        attendee.remind!
        attendee.confirm!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message explaining that payment has already been accepted" do
        visit(url)
        page.should have_content("You've already paid.")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end

    context "when the attendee has already declined" do
      before(:each) do
        attendee.invite!
        attendee.decline!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message stating that the declination has already been accepted" do
        visit(url)
        page.should have_content("Sorry, you have previously declined this event.")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end
  end

  describe "the confirm link" do
    let(:url) { EmailLink.confirm(attendee) }

    it "displays a reasonable error message for invalid tokens" do
      visit("/confirm/abc")
      page.should have_content("Sorry, that doesn't appear to be a valid link.")
    end

    context "when the attendee has already been reminded" do
      before(:each) do
        attendee.invite!
        attendee.pay!
        attendee.remind!
        visit(url)
      end

      it "redirects home" do
        current_path.should == '/'
      end

      it "displays a message accepting the confirmation" do
        page.should have_content("Your attendance has been confirmed.")
      end

      it "updates the attendee to 'confirmed'" do
        Attendee.find(attendee.id).state.should == "confirmed"
      end
    end

    context "when the attendee has already confirmed" do
      before(:each) do
        attendee.invite!
        attendee.pay!
        attendee.remind!
        attendee.confirm!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message explaining that confirmation has already been accepted" do
        visit(url)
        page.should have_content("Your attendance has been confirmed.")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end

    context "when the attendee has already declined" do
      before(:each) do
        attendee.invite!
        attendee.decline!
        visit(url)
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message stating that the declination has already been accepted" do
        visit(url)
        page.should have_content("Sorry, you have previously declined this event.")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end
  end

  describe "the decline link" do
    let(:url) { EmailLink.decline(attendee) }

    it "displays a reasonable error message for invalid tokens" do
      visit("/decline/abc")
      page.should have_content("Sorry, that doesn't appear to be a valid link.")
    end

    context "when the invitation is still valid" do
      before(:each) do
        attendee.invite!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message accepting the declination" do
        visit(url)
        page.should have_content("We're sorry that you can't attend. Thanks for letting us know.")
      end

      it "updates the attendee to 'declined'" do
        visit(url)
        Attendee.find(attendee.id).state.should == "declined"
      end
    end

    context "when the invitation has been revoked" do
      before(:each) do
        attendee.invite!
        attendee.revoke_invitation!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message accepting the declination" do
        visit(url)
        page.should have_content("We're sorry that you can't attend. Thanks for letting us know.")
      end

      it "updates the attendee to 'declined'" do
        visit(url)
        Attendee.find(attendee.id).state.should == "declined"
      end
    end

    context "when the attendee has already paid" do
      before(:each) do
        attendee.invite!
        attendee.pay!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message explaining that payment has already been accepted" do
        visit(url)
        page.should have_content("You've already paid")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end

    context "when the attendee has already been reminded" do
      before(:each) do
        attendee.invite!
        attendee.pay!
        attendee.remind!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message explaining that payment has already been accepted" do
        visit(url)
        page.should have_content("You've already paid.")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end

    context "when the attendee has already confirmed" do
      before(:each) do
        attendee.invite!
        attendee.pay!
        attendee.remind!
        attendee.confirm!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message explaining that payment has already been accepted" do
        visit(url)
        page.should have_content("You've already paid.")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end

    context "when the attendee has already declined" do
      before(:each) do
        attendee.invite!
        attendee.decline!
      end

      it "redirects home" do
        visit(url)
        current_path.should == '/'
      end

      it "displays a message stating that the declination has already been accepted" do
        visit(url)
        page.should have_content("We're sorry that you can't attend. Thanks for letting us know.")
      end

      it "doesn't change the state of the attendee" do
        expect { visit(url) }.to_not change(Attendee.find(attendee.id), :state)
      end
    end
  end
end
