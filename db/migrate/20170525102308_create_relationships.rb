class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :interest_id

      t.timestamps
    end
    add_index :relationships, :user_id
    add_index :relationships, :interest_id
    add_index :relationships, [:user_id, :interest_id], unique: true
  end
end
