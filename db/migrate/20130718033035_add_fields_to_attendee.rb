class AddFieldsToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :gender,       :string
    add_column :attendees, :age,          :integer
    add_column :attendees, :profession,   :string
    add_column :attendees, :tweet_idea,   :string,  limit: 140
    add_column :attendees, :scholarship,  :boolean, default: false
  end
end
