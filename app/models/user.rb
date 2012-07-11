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
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :avatar,
                  :university, :biography, :job, :birth_date

  has_attached_file :avatar, styles: { thumb: '100x100>'}

  before_save { |user| user.email.downcase! }
# before_save :create_remember_token

  VALID_EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.(?:[A-Z]{2}|com|org|net|edu|gov|gouv|mil|biz|info|mobi|name|aero|asia|jobs|museum)$/i

  # TODO: Should refactor
  validates :first_name, { presence: true, length: { maximum: 25 }, format: { with: /\A[a-zA-Z]+\z/, message: 'Only letters allowed' } }
  validates :last_name,  { presence: true, length: { maximum: 25 }, format: { with: /\A[a-zA-Z]+\z/, message: 'Only letters allowed' } }

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, :if => ->{ new_record? || !password.nil? }
  validates :password_confirmation, presence: true, :if => ->{ new_record? || !password_confirmation.nil? }
  validates_confirmation_of :password
end
