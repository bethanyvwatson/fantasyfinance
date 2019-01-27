class AddProfilesToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :profile_id, :bigint
    add_foreign_key :transactions, :profiles, name: "fk_transactions_profiles"
  end
end
