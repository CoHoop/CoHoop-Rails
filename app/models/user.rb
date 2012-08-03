# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  birth_date             :datetime
#  email                  :string(255)
#  university             :string(255)
#  biography              :text
#  job                    :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  # Microhoops
  has_many :microhoops

  # Relations
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: 'Relationship', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :tags_relationships, class_name: 'UsersTagsRelationship', foreign_key: "user_id"
  has_many :tags, through: :tags_relationships

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :avatar,
                  :university, :biography, :job, :birth_date

  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  has_attached_file :avatar, styles: { thumb: '100x100>'}
  validates_attachment :avatar,
                       content_type: { content_type: %w(image/jpg image/jpeg image/png image/gif), message: "format is invalid." },
                       size: { in: 0..2.megabytes, message: 'exceeded' }
  # TODO : Do we need a message if the file is missing or simply do nothing ?
  # validates_attachment_presence :avatar, message: "The file is missing", on: :update

  before_save { |user| user.email.downcase! }

  VALID_EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.(?:[A-Z]{2}|com|org|net|edu|gov|gouv|mil|biz|info|mobi|name|aero|asia|jobs|museum)$/i

  # TODO: Should refactor
  validates :first_name, { presence: true, length: { maximum: 25 }, format: { with: /\A[a-zA-Z]+\z/, message: 'Only letters allowed' } }
  validates :last_name,  { presence: true, length: { maximum: 25 }, format: { with: /\A[a-zA-Z]+\z/, message: 'Only letters allowed' } }

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, :if => ->{ new_record? || !password.nil? }
  validates :password_confirmation, presence: true, :if => ->{ new_record? || !password_confirmation.nil? }
  validates_confirmation_of :password

  # ------------------------------------------------------
  # TODO: should refactor in a UserRelationshipInterface |
  # ------------------------------------------------------

  # Public : Follows a given user
  #
  # user - the user to follow, should be kind_of User
  #
  # Returns the newly created relationship.
  def follow!(user)
    self.relationships.create!(followed_id: user.id)
  end

  # Public : Unfollows a given user
  #
  # user - the user to unfollow, should be kind_of User
  #
  # Returns the destroyed relationship.
  def unfollow!(user)
    self.relationships.find_by_followed_id!(user.id).destroy
  end

  # Public : Checks if a user is followed
  #
  # user - the user to check, should be kind_of User
  #
  # Returns a Boolean.
  def following?(user)
    self.relationships.find_by_followed_id(user.id)
  end

  # ------------------------------------------------------
  # TODO: should refactor in a UserTagsRelationshipInterface |
  # ------------------------------------------------------

  #
  # OPTIMIZE: Number of requests ~~
  #

  # Public: list all user's main tags
  #
  # Returns an Array of Tags.
  def main_tags
    tags_ids = tags_relationships.where(main_tag: true).collect { |relation| relation.tag_id }
    Tag.where(id: tags_ids)
  end

  # Public: list all user's secondary tags
  #
  # Returns an Array of Tags.
  def secondary_tags
    tags_ids = tags_relationships.where(main_tag: false).collect { |relation| relation.tag_id }
    Tag.where(id: tags_ids)
  end

  # TODO: Should strip special characters like "."
  # Public: Add multiple tags to a user: tags a user.
  #
  # names - String of tags, separated by commas (example: "Foo, Bar, World")
  # opts  - Options to pass, (default: { main: false })
  #         main - If the tag is a main tag or a secondary tag, as a Boolean.
  #
  # Returns the name of the tag as a String if the tags alread exists, false otherwise.
  def tag!(names, opts = { main: false } )
    # Creates an index of all users tags relationships ids.
    # Example: [<Tag#1 name: 'Hola'>, <Tag#8 name: 'Segoritas'>] => [1, 8]
    user_tags = tags_relationships.map { |r| r.tag_id }

    # Clean each tag name : 'Tag1  , Tag3 , Tag1' => ["Tag1", "Tag3"]
    # TODO: Maybe refactor map(&:strip).to_set
    names.split(',').map(&:strip).to_set.each do |name|
      tag = Tag.where(name: name.capitalize).first_or_initialize
      if user_tags.include? tag.id
        # TODO: Should perhaps display all erors
        return name
      else
        tag.save!
        tags_relationships.build(tag_id: tag.id, main_tag: opts[:main])
      end
    end
    self.save!
    false
  end

  # Public: Remove one tag from the user.
  #
  # names_or_ids - list of names or ids (example: [1, 2, 3 | Economy, Geography, Poneys].)
  #
  # Returns nothing.
  def untag! names_or_ids
    names_or_ids.split(',').each do |name_or_id|
      name_or_id.strip!
      id = name_or_id[/\A\d+\Z/] ? name_or_id.to_i : Tag.limit(1).where(name: name_or_id).first.id # If it is an id : a name
      tags_relationships.destroy(id)
    end
  end

  # Public: Checks if a user is tagged with a particular tag.
  #
  # name - the name of the tag to check as a String.
  #
  # Returns a boolean.
  def is_tagged? name
    tag = Tag.where(name: name)
    tags_relationships.find(tag)
  rescue ActiveRecord::RecordNotFound
    false
  end
  alias :has_tag? :is_tagged?
  alias :tagged?  :is_tagged?
end
