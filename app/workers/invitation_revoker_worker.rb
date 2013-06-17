class InvitationRevokerWorker

  include Sidekiq::Worker

  def perform(attendee_id)
    attendee = Attendee.find(attendee_id)
    begin
      attendee.revoke_invitation!
      attendee.emails.create(event: 'revoke_invitation').deliver
    rescue StateMachine::InvalidTransition
    end
  end

end
