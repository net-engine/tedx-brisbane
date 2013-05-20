class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :attendee_id
      t.string :event

      t.timestamps
    end
  end
end
