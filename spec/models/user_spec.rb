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

require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create :user_with_avatar }
  let(:other_user) { FactoryGirl.create :user }

  subject { user }

  it 'should have a first name '           do should respond_to :first_name  end
  it 'should have a last name '            do should respond_to :last_name  end
  it 'should have an email'                do should respond_to :email end
  it 'should have an avatar'               do should respond_to :avatar end
  it 'should have an university'           do should respond_to :university end
  it 'should have a biography'             do should respond_to :biography end
  it 'should have a job'                   do should respond_to :job end
  it 'should have a birth_date'            do should respond_to :birth_date end
  it 'should have a password digest'       do should respond_to :password_digest end
  it 'should have a password'              do should respond_to :password end
  it 'should have a password confirmation' do should respond_to :password_confirmation end

  it { should have_attached_file(:avatar) }
  it { should respond_to(:microhoops) }
  it { should respond_to(:relationships) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:followers) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }
  it { should respond_to(:following?) }

  it { should be_valid }

  describe 'relationship methods' do
    let(:other_user) { FactoryGirl.create :user }

    describe 'follow!' do
      it 'should raise an error if the followed user does not exists' do
        expect { user.follow! stub(id: 42) }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'should make the user follow a given user' do
        user.follow! other_user
        user.followed_users.should include other_user
      end
    end # follow!

    describe 'following?' do
      it 'should return true if the given user is followed' do
        user.follow! other_user
        user.following?(other_user).should be_true
      end
      it 'should return false if the given user is not followed' do
        user.following?(stub(id: 42)).should be_false
      end
    end # following

    describe 'unfollow!' do
      it 'should raise an error if we try to follow a user we are not following' do
        expect { user.unfollow! other_user }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'should make the user unfollow a given user' do
        user.follow! other_user
        user.unfollow! other_user
        user.followed_users.should_not include other_user
      end
    end # unfollow!

  end # relationship methods

  describe 'following' do
    before { user.follow! other_user }
    it { should be_following other_user }
    its(:followed_users) { should include other_user }

    describe 'and unfollowing' do
      before { user.unfollow! other_user }
      it { should_not be_following other_user }
      its(:followed_users) { should_not include other_user }
    end # unfollowing
  end # following

  describe 'followed_user' do
    before { user.follow! other_user }
    subject { other_user }
    its(:followers) { should include user }
  end

end
