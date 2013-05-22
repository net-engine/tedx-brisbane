ActiveAdmin.register Attendee do
  controller do
    def permitted_params
      params.permit(:attendee => [:email_address, :round])
    end
  end
end
