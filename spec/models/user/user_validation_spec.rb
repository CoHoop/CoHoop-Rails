require 'spec_helper'

describe User do
  before do
     @user = FactoryGirl.create :user
  end

  subject { @user }

  describe 'when first name' do
    describe 'is not present' do
      before { @user.first_name = '' }
      it { should_not be_valid }
    end
    describe 'is too long' do
      before { @user.first_name = 'a' * 26 }
      it { should_not be_valid }
    end
    describe 'contains digits or underscore' do
      before { @user.first_name = 'Foo_b4r' }
      it { should_not be_valid }
    end
  end # when first name

  describe 'when last name' do
    describe 'is not present' do
      before { @user.last_name = '' }
      it { should_not be_valid }
    end
    describe 'is too long' do
      before { @user.last_name = 'a' * 26 }
      it { should_not be_valid }
    end
    describe 'contains digits or underscore' do
      before { @user.last_name = 'Foo_b4r' }
      it { should_not be_valid }
    end
  end # when last name

  describe 'when email' do
    describe 'is not present' do
      before { @user.email = '' }
      it { should_not be_valid }
    end

    describe 'is already taken' do
      before do
        @user_copy = User.new(first_name: 'foo', last_name: 'bar',
                         email: @user.email, password: 'foobar',
                         password_confirmation: 'foobar')
      end
      it { @user_copy.should_not be_valid }
    end

    describe 'is not correctly formatted' do
      it 'should invalidate' do
        %w(user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com).each do |invalid_address|
          @user.email = invalid_address
          should_not be_valid
        end
      end
    end

    describe 'is saved' do
      it 'should be downcased' do
        @user.email = 'example@OTHER.com'
        @user.save
        @user.email.should == 'example@other.com'
      end
    end
  end # when email

  describe 'when password' do
    describe 'is not present' do
      before { @user.password = @user.password_confirmation = '' }
      it { should_not be_valid }
    end
    describe 'is nil' do
      before { @user.password = @user.password_confirmation = nil }
      it { should_not be_valid }
    end
    describe 'is too short' do
      before { @user.password = @user.password_confirmation = 'a' * 5 }
      it { should_not be_valid }
    end
    describe 'does not match confirmation' do
      before do
        @user.password_confirmation = 'barfoo'
      end
      it { should_not be_valid }
    end
  end # when password
end
