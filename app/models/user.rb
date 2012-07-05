# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  birth_date      :datetime
#  email           :string(255)
#  university      :string(255)
#  avatar_id       :integer
#  biography       :text
#  job             :string(255)
#  password        :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :email, :avatar_id,
                  :university, :biography, :job, :birth_date,
                  :password, :password_confirmation

  before_save { |user| user.email.downcase! }
  #before_save :create_remember_token

  VALID_EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.(?:[A-Z]{2}|com|org|net|edu|gov|gouv|mil|biz|info|mobi|name|aero|asia|jobs|museum)$/i

  # TODO: Should refactor
  validates :first_name, { presence: true, length: { maximum: 25 }, format: { with: /\A[a-zA-Z]+\z/, message: 'Only letters allowed' } }
  validates :last_name,  { presence: true, length: { maximum: 25 }, format: { with: /\A[a-zA-Z]+\z/, message: 'Only letters allowed' } }

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
