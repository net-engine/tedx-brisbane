ActiveAdmin.register Attendee do
  index do
    selectable_column
    column :first_name
    column :last_name
    column :email_address
    column :state
    column :round
    column :gender
    column :age
    column :profession
    column :tweet_idea
    column :scholarship
    column :student
    default_actions
  end

  filter :state, :as => :select, collection: proc { Attendee.new.state_paths.to_states }
  filter :first_name
  filter :last_name
  filter :email_address
  filter :round

  controller do
    def permitted_params
      params.permit(:attendee => [:email_address, :round, :first_name, :last_name, :gender, :age, :profession, :tweet_idea, :scholarship, :student])
    end
  end

  batch_action :invite, priority: 1 do |selection|
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

  batch_action :remind, priority: 3 do |selection|
    Attendee.find(selection).each do |attendee|
      begin
        attendee.remind!
        attendee.emails.create(event: 'remind').deliver
      rescue StateMachine::InvalidTransition
      end
    end
    redirect_to collection_path, notice: "Successfully reminded #{selection.size} attendees"
  end

  batch_action :confirm, priority: 4 do |selection|
    Attendee.find(selection).each do |attendee|
      begin
        attendee.confirm!
        attendee.emails.create(event: 'confirm').deliver
      rescue StateMachine::InvalidTransition
      end
    end
    redirect_to collection_path, notice: "Successfully confirmed #{selection.size} attendees"
  end

  batch_action :decline, priority: 6 do |selection|
    Attendee.find(selection).each do |attendee|
      begin
        attendee.decline!
        attendee.emails.create(event: 'decline').deliver
      rescue StateMachine::InvalidTransition
      end
    end
    redirect_to collection_path, notice: "Successfully declined #{selection.size} attendees"
  end

  batch_action :uninvite, priority: 5 do |selection|
    Attendee.find(selection).each do |attendee|
      begin
        attendee.revoke_invitation!
        attendee.emails.create(event: 'revoke_invitation').deliver
      rescue StateMachine::InvalidTransition
      end
    end
    redirect_to collection_path, notice: "Successfully revoked invitations for #{selection.size} attendees"
  end

  batch_action :gift, priority: 2 do |selection|
    Attendee.find(selection).each do |attendee|
      begin
        attendee.provide_complimentary_ticket!
        attendee.emails.create(event: 'provide_complimentary_ticket').deliver
      rescue StateMachine::InvalidTransition
      end
    end
    redirect_to collection_path, notice: "Successfully provided complimentary tickets for #{selection.size} attendees"
  end
end
