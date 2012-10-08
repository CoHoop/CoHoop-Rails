# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :documents_pad_groups_relationship, :class => 'DocumentsPadGroupsRelationships' do
    document_id 1
    pad_group_id 1
  end
end
