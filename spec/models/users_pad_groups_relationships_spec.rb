require 'spec_helper'

describe UsersPadGroupsRelationships do
  let(:user)  { FactoryGirl.create :user }
  let(:group) { FactoryGirl.create :pad_group }
  let(:group_relationship) { user.group_relationships.build(group_id: group.id) }
  let(:user_relationship)  { group.user_relationships.build(user_id: user.id) }

  subject { group_relationship }

  it { should be_valid }

  it { should respond_to(:user) }
  it { user_relationship.should respond_to(:group) }
  its(:user)  { should == user }
  it { user.group.should == group }
end
