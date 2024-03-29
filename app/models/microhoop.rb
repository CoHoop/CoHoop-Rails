require 'tag_extractor'

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

  def vote_up
    self.update_attribute(:vote_count, self.vote_count.to_i + 1)
  end

  private
    def attach_tags
      TagExtractor.tag_separator = '#'
      self.content.extract_tags.each do |tag_name|
        tag = Tag.find_or_create_by_name(tag_name.downcase)
        relation = MicrohoopsTagsRelationship.find_by_tag_id_and_microhoop_id(tag.id, self.id)
        self.tags_relationships.create!(tag_id: tag.id) unless self.tags_relationships.include? relation
      end
    end
end
