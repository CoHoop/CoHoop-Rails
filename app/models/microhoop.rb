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
  belongs_to :user

  attr_accessible :content, :urgent

  validates :content, presence: true
  validates :user_id, presence: true
end
