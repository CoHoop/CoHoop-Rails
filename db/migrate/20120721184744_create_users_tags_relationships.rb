class CreateUsersTagsRelationships < ActiveRecord::Migration
  def change
    create_table :users_tags_relationships do |t|
      t.integer :user_id
      t.integer :tag_id
      t.integer :main_tag, default: false

      t.timestamps
    end
    add_index :users_tags_relationships, :user_id
    add_index :users_tags_relationships, :tag_id
    add_index :users_tags_relationships, [:user_id, :tag_id], unique: true
  end
end
