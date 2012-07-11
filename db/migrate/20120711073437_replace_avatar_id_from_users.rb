class ReplaceAvatarIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :avatar_id
    change_table :users do |t|
      t.has_attached_file :avatar
    end
  end

  def down
    add_column :users, :avatar_id, :string
    drop_attached_file :users, :avatar
  end
end
