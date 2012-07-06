FactoryGirl.define do
  factory :user do
    first_name            "Firstname"
    last_name             "Lastname"
    sequence( :email ) { |n| "foo#{n}@ex#{n+1}ample.com" }
    password              'foobar'
    password_confirmation 'foobar'
    created_at            Time.now
    updated_at            Time.now
    university            'University'
    job                   'job'
    biography             'Real content like a <br />biography<br />'
  end
end
