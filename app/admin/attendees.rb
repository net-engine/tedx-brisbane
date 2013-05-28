ActiveAdmin.register Attendee do
  controller do
    def permitted_params
      params.permit(:attendee => [:email_address, :round])
    end
  end

  batch_action :invite do |selection|
    Attendee.find(selection).each do |attendee|
      begin
        attendee.invite!
        attendee.emails.create(event: 'invite').deliver
        InvitationRevokerWorker.perform_in(5.days, attendee.id)
      rescue StateMachine::InvalidTransition
      end
    end
    redirect_to collection_path, notice: "Successfully invited #{selection.size} attendees"
  end
end
