FactoryGirl.define do
  factory :user do
    sequence( :first_name )  { |n| "FirstName#{n}" }
    sequence( :last_name )  { |n| "LastName#{n}" }
    sequence( :email ) { |n| "foo#{n}@example.com" }
    password              'foobar'
    password_confirmation 'foobar'
  end
end
