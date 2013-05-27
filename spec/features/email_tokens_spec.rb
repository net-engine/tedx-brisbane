require 'spec_helper'

describe "Receiving links in emails" do
  describe "the pay link" do
    context "when the invitation is still valid" do
      it "redirects to the payment page for the attendee"
    end

    context "when the invitation has been revoked" do
      it "redirects home"
      it "displays a message explaining that the invitation timed out"
    end

    context "when the attendee has already paid" do
      it "redirects home"
      it "displays a message explaining that payment has already been accepted"
    end

    context "when the attendee has already been reminded" do
      it "redirects home"
      it "displays a message explaining that payment has already been accepted"
    end

    context "when the attendee has already confirmed" do
      it "redirects home"
      it "displays a message explaining that payment has already been accepted"
    end

    context "when the attendee has already declined" do
      it "redirects home"
      it "displays a message stating that the declination has already been accepted"
    end
  end

  describe "the confirm link" do
    context "when the attendee has already been reminded" do
      it "redirects home"
      it "displays a message accepting the confirmation"
      it "updates the attendee to 'confirmed'"
    end

    context "when the attendee has already confirmed" do
      it "redirects home"
      it "displays a message explaining that confirmation has already been accepted"
    end

    context "when the attendee has already declined" do
      it "redirects home"
      it "displays a message stating that the declination has already been accepted"
    end
  end

  describe "the decline link" do
    context "when the invitation is still valid" do
      it "redirects home"
      it "displays a message accepting the declination"
      it "updates the attendee to 'declined'"
    end

    context "when the invitation has been revoked" do
      it "redirects home"
      it "displays a message accepting the declination"
      it "updates the attendee to 'declined'"
    end

    context "when the attendee has already paid" do
      it "redirects home"
      it "displays a message explaining that payment has already been accepted"
    end

    context "when the attendee has already been reminded" do
      it "redirects home"
      it "displays a message explaining that payment has already been accepted"
    end

    context "when the attendee has already confirmed" do
      it "redirects home"
      it "displays a message explaining that payment has already been accepted"
    end

    context "when the attendee has already declined" do
      it "redirects home"
      it "displays a message stating that the declination has already been accepted"
    end
  end
end
