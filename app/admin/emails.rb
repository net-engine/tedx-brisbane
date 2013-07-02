ActiveAdmin.register Email do
  index do
    column "Attendee" do |email|
      email.to_name
    end
    column "Address" do |email|
      email.to_address
    end
    column "Browser Link" do |email|
      link_to email.event, EmailLink.for(email)
    end
  end

  filter :attendee
end
