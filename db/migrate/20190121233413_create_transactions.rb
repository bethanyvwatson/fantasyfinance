class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.float :amount, null: false
      t.datetime :date, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
