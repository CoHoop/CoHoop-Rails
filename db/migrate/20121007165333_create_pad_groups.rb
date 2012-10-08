class CreatePadGroups < ActiveRecord::Migration
  def change
    create_table :pad_groups do |t|
      t.string :name
      t.string :slug
      t.string :token

      t.timestamps
    end
  end
end
