# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :users_pad_groups_relationship, :class => 'UsersPadGroupsRelationships' do
    user_id 1
    pad_group_id 1
  end
end
