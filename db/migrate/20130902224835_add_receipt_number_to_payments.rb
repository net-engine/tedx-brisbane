class AddReceiptNumberToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :receipt_number, :string
  end
end
