# Needed to use fixture_file_upload
require 'action_dispatch'
include ActionDispatch::TestProcess


FactoryGirl.define do
  sequence( :email ) { |n| "foo#{n}@ex#{n+1}ample.com" }

  factory :user do
    first_name            "Firstname"
    last_name             "Lastname"
    email                 { FactoryGirl.generate(:email) }
    password              'foobar'
    password_confirmation 'foobar'
    created_at            Time.now
    updated_at            Time.now
    university            'University'
    job                   'job'
    biography             'Real content like a <br />biography<br />'
  end

  factory :user_with_avatar, class: User do
    first_name            "Firstname"
    last_name             "Lastname"
    email                 { FactoryGirl.generate(:email) }
    password              'foobar'
    password_confirmation 'foobar'
    created_at            Time.now
    updated_at            Time.now
    university            'University'
    job                   'job'
    biography             'Real content like a <br />biography<br />'
    avatar                { fixture_file_upload 'spec/fixtures/images/avatar.png', 'image/png' }
  end

end
