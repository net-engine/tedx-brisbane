class AddStudentToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :student,  :boolean
  end
end
