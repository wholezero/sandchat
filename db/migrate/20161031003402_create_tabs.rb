class CreateTabs < ActiveRecord::Migration[5.0]
  def change
    create_table :tabs do |t|
      t.string :tid, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :tabs, :tid, unique: true
    add_column :users, :tabs_count, :integer, default: 0
  end
end
