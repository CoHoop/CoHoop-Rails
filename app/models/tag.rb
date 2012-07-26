class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :users, through: :users_tags_relationships

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end