class AddStringTokenToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :token, :string
  end
end
