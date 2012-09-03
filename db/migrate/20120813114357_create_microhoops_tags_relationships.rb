class CreateMicrohoopsTagsRelationships < ActiveRecord::Migration
  def change
    create_table :microhoops_tags_relationships do |t|
      t.integer :microhoop_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :microhoops_tags_relationships, :microhoop_id
    add_index :microhoops_tags_relationships, :tag_id
    add_index :microhoops_tags_relationships, [:microhoop_id, :tag_id], unique: true
  end
end
