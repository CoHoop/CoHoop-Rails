class UsersTagsRelationship < ActiveRecord::Base
  attr_accessible :user_id, :main_tag

  belongs_to :user
  belongs_to :tag
end
