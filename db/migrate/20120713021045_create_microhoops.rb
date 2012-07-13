class CreateMicrohoops < ActiveRecord::Migration
  def change
    create_table :microhoops do |t|
      t.string :content,  null: false
      t.integer :user_id, null: false
      t.boolean :urgent,  null: false, default: false

      t.timestamps
    end
    add_index :microhoops, [:user_id, :created_at]
  end
end
