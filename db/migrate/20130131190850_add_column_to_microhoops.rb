class AddColumnToMicrohoops < ActiveRecord::Migration
  def change
    add_column :microhoops, :vote_count, :integer, default: 0
  end
end
