# == Schema Information
#
# Table name: microhoops
#
#  id         :integer         not null, primary key
#  content    :string(255)     not null
#  user_id    :integer         not null
#  urgent     :boolean         default(FALSE), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Microhoop < ActiveRecord::Base
  after_save :attach_tags # if self.content['#']
  belongs_to :user
  has_many :tags_relationships, class_name: 'MicrohoopsTagsRelationship', foreign_key: "microhoop_id"
  has_many :tags, through: :tags_relationships

  attr_accessible :content, :urgent

  validates :content, presence: true
  validates :user_id, presence: true

  private
    def attach_tags
      TagExtractor.tag_separator = '#'
      self.content.extract_tags.each do |tag_name|
        tag = Tag.find_or_create_by_name(tag_name.downcase)
        self.tags_relationships.create!(tag_id: tag.id)
      end
    end
end
