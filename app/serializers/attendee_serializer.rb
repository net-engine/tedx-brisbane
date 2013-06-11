class AttendeeSerializer < ActiveModel::Serializer
  attributes :id, :email_address, :state, :round, :first_name, :last_name
end
