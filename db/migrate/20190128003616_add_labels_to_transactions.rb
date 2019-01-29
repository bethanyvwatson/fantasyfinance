class AddLabelsToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :label_id, :bigint
    add_foreign_key :transactions, :labels, name: "fk_transactions_labels"
  end
end
