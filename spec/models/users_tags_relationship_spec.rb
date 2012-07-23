require 'spec_helper'

describe UsersTagsRelationship do
  let(:user) { FactoryGirl.create :user }
  let(:tag) { FactoryGirl.create :tag }
  let(:relationship) { user.tags_relationships.build(tag_id: tag.id) }
  let(:main_relationship) { user.tags_relationships.build(tag_id: tag.id, main_tag: 1) }

  subject { relationship }

  it { should be_valid }

  it { should respond_to(:user) }
  it { should respond_to(:tag) }
  its(:user) { should == user }
  its(:tag) { should == tag }

  describe 'main tags and secondary tags' do
    it 'defaults to secondary tag' do
      relationship.main_tag.should == 0
    end
    it 'can be a main tag' do
      main_relationship.main_tag.should == 1
    end
  end

  describe 'validation' do
    describe 'when user id is not specified' do
      before { relationship.user_id = nil }
      it { should_not be_valid }
    end
    describe 'when tag id is not specified' do
      before { relationship.tag_id = nil }
      it { should_not be_valid }
    end
  end
end
