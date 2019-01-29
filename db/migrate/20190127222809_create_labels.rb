class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :name, null: false
      t.text :description
      t.bigint :profile_id, null: false

      t.timestamps
    end

    add_foreign_key :labels, :profiles, name: "fk_labels_profiles"
    add_index :labels, :name, unique: true
  end
end
