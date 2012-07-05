require 'spec_helper'

describe 'User pages :' do
  include DisplayCase::ExhibitsHelper
  let(:user) { exhibit(FactoryGirl.create :user) }
  subject { page }

  # TODO: Should refactor this
  shared_examples_for "all user pages" do
    describe 'should have a correct title' do
      it { should have_selector('title', content: "CoHoop | #{page_title}") }
    end
  end

  describe 'profile page' do
    describe 'with a wrong user' do
      it 'should render 404 page' do
        visit(profile_path(id: 1, first: 'FirstName', last: 'Last'))
        should have_selector('title', content: '404')
      end
    end

    describe 'with a correct user' do
      before do
        user = FactoryGirl.create(:user)
        visit(profile_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))
      end
      let(:page_title) { user.user_name }
      it_should_behave_like 'all user pages'

      describe 'should display the user name' do
        pending 'and should be tested'
      end
      describe 'should display the avatar' do
        pending 'and should be tested'
      end
      describe 'should display a list of followers' do
        pending 'and should be tested'
      end
      describe 'should display a list of followed' do
        pending 'and should be tested'
      end
      describe 'should display social media links' do
        pending 'and should be tested'
      end
      describe 'may display a progress bar' do
        pending 'and should be tested'
      end
      describe 'should display the university' do
        pending 'and should be tested'
      end
      describe 'should display a job' do
        pending 'and should be tested'
      end
      describe 'should display a cursus' do
        pending 'and should be tested'
      end
      describe 'should display the tags' do
        pending 'and should be tested'
      end
      describe 'should display a biography' do
        pending 'and should be tested'
      end
      describe 'should display a list of share documents' do
        pending 'and should be tested'
      end
      describe 'should display a list of favorite documents' do
        pending 'and should be tested'
      end
      describe 'should have a link to switch in document view mode' do
        pending 'and should be tested'
      end
    end
  end
end