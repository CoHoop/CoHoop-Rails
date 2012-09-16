class CreateUsersDocumentsRelationships < ActiveRecord::Migration
  def change
    create_table :users_documents_relationships do |t|
      t.integer :user_id
      t.integer :document_id

      t.timestamps
    end
    add_index :users_documents_relationships, :user_id
    add_index :users_documents_relationships, :document_id
    add_index :users_documents_relationships, [:user_id, :document_id], unique: true
  end
end
