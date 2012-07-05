FactoryGirl.define do
  factory :user do
    first_name            "FirstName"
    last_name             "LastName"
    sequence( :email ) { |n| "foo#{n}@ex#{n+1}ample.com" }
    password              'foobar'
    password_confirmation 'foobar'
    created_at            Time.now
    updated_at            Time.now
  end
end
