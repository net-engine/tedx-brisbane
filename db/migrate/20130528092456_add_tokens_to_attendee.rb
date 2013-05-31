class AddTokensToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :pay_token, :string, unique: true
    add_index :attendees, :pay_token
    add_column :attendees, :decline_token, :string, unique: true
    add_index :attendees, :decline_token
    add_column :attendees, :confirm_token, :string, unique: true
    add_index :attendees, :confirm_token
  end
end
