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

require 'spec_helper'

describe Microhoop do
  before do
    @user  = FactoryGirl.create :user
    @micro = @user.microhoops.build(content: 'foobar')
  end

  subject { @micro }

  it 'should have content'           do should respond_to :content end
  it 'should have an urgence state'  do should respond_to :urgent end
  it 'should have an user id'        do should respond_to :user_id end
  its(:urgent) { should == false }

  it { should be_valid }

  describe 'should respond to user' do
    it { @micro.user.should == @user }
  end

  describe 'when it has no user assigned' do
    before { @micro.user_id = nil }
    it { should_not be_valid }
  end

  describe 'when it is empty' do
    before { @micro.content = '' }
    it { should_not be_valid }
  end

  describe 'attributes accessors' do
    it 'should not allow access to the user_id attribute' do
      expect { Microhoop.new(user_id: 1, content: 'foo') }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  describe 'microhoop tagging' do
    before do
      @micro.content = 'MH with #tag1, #tag2, #tag3'
      @micro.save
    end
    it 'is created with tags' do
      @micro.tags.collect { |t| t.name }.should include('tag1', 'tag2', 'tag3')
    end
  end
end
