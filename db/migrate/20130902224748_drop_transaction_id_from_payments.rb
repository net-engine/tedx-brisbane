class DropTransactionIdFromPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :transaction_id
  end
end
