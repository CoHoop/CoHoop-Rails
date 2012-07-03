require 'spec_helper'

describe "Authentication" do

  describe 'User' do
    describe 'registration' do
      before { visit new_user_registration_path }

      describe "shouldn't be able to register" do
        describe "with invalid credentials" do
          describe 'without a name' do

          end
          describe 'without an email' do

          end
          describe 'with a wring email' do

          end
          describe 'with no credentials' do

          end
        end # with invalid credentials

        describe 'if already logged in' do

        end # if already logged in

      end # shouldn't be able to register

      describe "should be able to register" do
        describe "with valid credentials" do

        end
      end # should be able to register

      describe "once registered" do
        describe 'should be logged in' do

        end

        describe 'should be redirected to his feed' do
          pending 'Need to integrate the feed'
        end
      end # should be logged in once registered
    end # registration

    describe 'log in' do
      before { visit root_path }
      describe "shouldn't be able to log in" do
        describe 'with invalid credentials' do

        end

        describe 'with no credentials' do

        end

        describe 'if already logged in' do

        end
      end # shouldn't be able to log in

      describe 'should be able to log in' do
        describe 'with valid credentials' do

        end
      end # should be able to log in

      describe 'once logged in' do
        describe 'he should be able to log out' do

        end

        describe 'he should be redirected to his feed' do
          pending 'Need to integrate the feed'
        end

        describe 'he should be able to visit his profile' do
          pending 'Need to integrate the profile'
        end
      end # once logged in
    end

  end # User
end
