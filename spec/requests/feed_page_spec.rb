require 'spec_helper'

describe "Feeds" do
  let(:user) { FactoryGirl.create :user }
  subject { page }

  describe "Feed page" do
    describe 'cannot be accessed if user is not signed in' do
      specify do
        visit root_path
        should have_selector('title', content: 'Home')
      end
    end
    describe 'can be accessed if the user is signed in' do
      before { sign_in_as user }
      after  { page.should have_selector('title', content: 'News') }
      specify 'from root_path' do
        visit root_path
      end
      describe 'from feed_path' do
        specify 'with tag parameter' do
          visit feed_path(feed_type: 'tags')
        end
        specify 'with community parameter' do
          visit feed_path(feed_type: 'community')
        end
      end
    end # can be accessed from
  end
end
