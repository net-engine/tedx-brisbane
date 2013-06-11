class AddNamesToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :first_name, :string
    add_column :attendees, :last_name, :string
  end
end
