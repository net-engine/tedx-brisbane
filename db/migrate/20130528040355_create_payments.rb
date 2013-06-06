class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :attendee_id
      t.decimal :amount
      t.string :transaction_id
      t.string :masked_number
      t.string :card_type

      t.timestamps
    end
  end
end
