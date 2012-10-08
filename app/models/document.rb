class Document < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :slug, :token

  has_many :users, through: :users_documents_relationships

  has_many :pad_groups_relationships, class_name: 'DocumentsGroupsRelationship', foreign_key: "document_id"
  has_many :pad_groups, through: :pad_groups_relationships

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  def create_slug
    self.slug = name.to_url
  end

  def create_token
    self.token = SecureRandom::uuid
  end
end
