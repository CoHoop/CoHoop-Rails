class CreateUsersPadGroupsRelationships < ActiveRecord::Migration
  def change
    create_table :users_pad_groups_relationships do |t|
      t.integer :user_id
      t.integer :pad_group_id

      t.timestamps
    end
  end
end
