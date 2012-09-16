class AddNameAndSlugtoDocument < ActiveRecord::Migration
  def change
    add_column :documents, :name, :string
    add_column :documents, :slug, :string
  end
end
