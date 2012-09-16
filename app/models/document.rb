class Document < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :slug

  has_many :users, through: :users_documents_relationships

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, presence: true

  def create_slug
    self.slug = name.to_url
  end
end
