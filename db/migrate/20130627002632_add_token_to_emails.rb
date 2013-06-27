class AddTokenToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :token, :string, unique: true
    add_index :emails, :token
  end
end
