class MicrohoopsTagsRelationship < ActiveRecord::Base
  attr_accessible :microhoop_id, :tag_id

  belongs_to :microhoop
  belongs_to :tag

  validates :microhoop_id, presence: true
  validates :tag_id,       presence: true
end
