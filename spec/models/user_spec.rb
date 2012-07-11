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
  before do
    @user = FactoryGirl.create :user
  end

  subject { @user }

  it 'should have a first name '           do should respond_to :first_name  end
  it 'should have a last name '            do should respond_to :last_name  end
  it 'should have an email'                do should respond_to :email end
  it 'should have an avatar'               do should respond_to :avatar_id end
  it 'should have an university'           do should respond_to :university end
  it 'should have a biography'             do should respond_to :biography end
  it 'should have a job'                   do should respond_to :job end
  it 'should have a birth_date'            do should respond_to :birth_date end
  it 'should have a password digest'       do should respond_to :password_digest end
  it 'should have a password'              do should respond_to :password end
  it 'should have a password confirmation' do should respond_to :password_confirmation end

  it { should be_valid }
end
