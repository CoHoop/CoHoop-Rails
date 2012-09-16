# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :users_documents_relationship, :class => 'UsersDocumentsRelationships' do
    user_id 1
    document_id 1
  end
end
