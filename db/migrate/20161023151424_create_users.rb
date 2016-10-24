class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.text :uid, null: false
      t.text :name
      t.text :picture
      t.text :pronouns

      t.timestamps
    end
    add_index :users, :uid, unique: true
  end
end
