class UsersDocumentsRelationship < ActiveRecord::Base
  attr_accessible :document_id #, :user_id

  belongs_to :user
  belongs_to :document

  validates :user_id, presence: true
  validates :document_id,  presence: true
end
