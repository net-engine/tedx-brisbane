class AddRoundToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :round, :integer, default: 1
  end
end
