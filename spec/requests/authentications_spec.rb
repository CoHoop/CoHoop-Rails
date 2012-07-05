require 'spec_helper'

describe "Authentication" do

  describe 'User' do
    describe 'registration' do
      before { visit new_user_registration_path }
      # TODO: Should be more generic
      let(:error_selector) { '#error_explanation' }
      let(:register_button) { 'Register' }

      describe "shouldn't be able to register" do

        describe "with invalid credentials:" do
          before(:each) do
            # With fill in with valid credentials at first
            within(:css, "#registration-form") do
              fill_in 'user_first_name', with: 'Firstname'
              fill_in 'user_last_name',  with: 'Lastname'
              fill_in 'user_email',      with: 'foobar@foo.com'
              fill_in 'user_password',   with: 'foobar'
              fill_in 'user_password_confirmation',   with: 'foobar'
            end
          end

          describe 'without a name' do
            before do
              within(:css, "#registration-form") do
                fill_in 'user_first_name', with: ''
              end
              click_on register_button
            end
            it { should have_selector(error_selector) }
          end #

          describe 'without an email' do
            before do
              within(:css, "#registration-form") do
                fill_in 'user_email', with: ''
              end
              click_on register_button
            end
            it { should have_selector(error_selector) }
          end #

          describe 'with a wrong email' do
            before do
              within(:css, "#registration-form") do
                fill_in 'user_email', with: 'foobar@foobar'
              end
              click_on register_button
            end
            it { should have_selector(error_selector) }
          end #

          describe 'with no credentials' do
            before do
              within(:css, "#registration-form") do
                fill_in 'user_first_name', with: ''
                fill_in 'user_last_name',  with: ''
                fill_in 'user_email',      with: ''
                fill_in 'user_password',   with: ''
                fill_in 'user_password_confirmation',   with: ''
              end
              click_on register_button
            end
            it { should have_selector(error_selector) }
          end #
        end # with invalid credentials

        describe 'if already logged in' do
          before do
            user = FactoryGirl.create :user
            sign_in_as user
            visit new_user_registration_path
          end
          it { should have_content('already signed in') }
        end # if already logged in

      end # shouldn't be able to register

      describe "should be able to register" do
        before do
          u = FactoryGirl.build(:user)
          within(:css, "#registration-form") do
            fill_in 'user_first_name', with: u.first_name
            fill_in 'user_last_name',  with: u.last_name
            fill_in 'user_email',      with: u.email
            fill_in 'user_password',   with: u.password
            fill_in 'user_password_confirmation', with: u.password
          end
        end
        describe "with valid credentials" do
          it 'should create an user' do
            expect { click_button register_button }.to change(User, :count).by 1
          end
        end # with valid credentials
      end # should be able to register

      describe "once registered" do
        before do
          u = FactoryGirl.build(:user)
          within(:css, "#registration-form") do
            fill_in 'user_first_name', with: u.first_name
            fill_in 'user_last_name',  with: u.last_name
            fill_in 'user_email',      with: u.email
            fill_in 'user_password',   with: u.password
            fill_in 'user_password_confirmation', with: u.password
          end
        end
        describe 'should be logged in' do
          before { click_button register_button }
          it { should have_link 'Log out' }
        end

        describe 'should be redirected to his feed' do
          pending 'Need to integrate the feed'
        end
      end # should be logged in once registered
    end # registration

    describe 'log in' do
      before { visit root_path }
      subject { page }

      describe "shouldn't be able to log in" do
        describe 'with invalid credentials' do
          before do
            fill_in 'user_email', with: 'mistake@miscom'
            fill_in 'user_password', with: 'mist'
            click_on 'Log in'
          end
          it { should have_content 'Invalid' }
        end

        describe 'with no credentials' do
          before do
            fill_in 'user_email', with: ''
            fill_in 'user_password', with: ''
            click_on 'Log in'
          end
          it { should have_content 'Invalid email or password.' }
        end

        describe 'if already logged in' do
          before do
            sign_in_as_a_valid_user
            visit new_user_session_path
          end
          it { should have_content 'already signed in' }
        end
      end # shouldn't be able to log in

      describe 'should be able to log in' do
        describe 'with valid credentials' do
          before do
            sign_in_as_a_valid_user
          end
          it { should have_link 'Log out' }
        end
      end # should be able to log in

      describe 'once logged in' do
        before { @user = sign_in_as_a_valid_user }
        describe 'he should be able to log out' do
          before { click_on 'Log out' }
          it { should have_content 'Signed out successfully.' }
        end

        describe 'he should be redirected to his feed' do
          pending 'Need to integrate the feed'
        end

        describe 'he should be able to visit his profile' do
          before { click_on 'Profile' }
          it { should have_selector 'title', content: "#{@user.first_name} #{@user.last_name}" }
        end
      end # once logged in
    end

  end # User
end

