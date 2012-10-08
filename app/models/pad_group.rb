class PadGroup < ActiveRecord::Base
  attr_accessible :name, :slug, :token

  has_many :users     through: :users_groups_relationships
  has_many :documents through: :documents_groups_relationships

  validates :name
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  def create_slug(user)
    self.slug = if name.blank?
                  self.token
                else
                  name.to_url + '-' + id
                end
  end

  def create_token
    self.token = SecureRandom::uuid.to_url
  end
end
