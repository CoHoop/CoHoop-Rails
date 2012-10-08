require 'spec_helper'

describe DocumentsPadGroupsRelationships do
  let(:document)  { FactoryGirl.create :document }
  let(:group) { FactoryGirl.create :pad_group }
  let(:group_relationship) { document.group_relationships.build(group_id: group.id) }
  let(:document_relationship)  { group.document_relationships.build(document_id: document.id) }

  subject { group_relationship }

  it { should be_valid }

  it { should respond_to(:user) }
  it { document_relationship.should respond_to(:group) }
  its(:user)  { should == user }
  it { document.group.should == group }
end
