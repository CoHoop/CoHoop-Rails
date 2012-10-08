class CreateDocumentsPadGroupsRelationships < ActiveRecord::Migration
  def change
    create_table :documents_pad_groups_relationships do |t|
      t.integer :document_id
      t.integer :pad_group_id

      t.timestamps
    end
  end
end
