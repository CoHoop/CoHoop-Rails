require 'spec_helper'

describe "Feeds" do
  let(:user) { FactoryGirl.create :user_with_avatar }
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
    describe 'elements' do
      before do
        sign_in_as user
        visit root_path
      end
      describe 'displays the user avatar' do
        it { should have_selector("img[src$='#{user.avatar.url(:thumb)}']") }
      end
      describe 'for community feed' do
        describe "displaying of all users's community microhoops" do
          before do
          end
          it { ap user.followed_users }
        end # community feed
      end # elements
    end
  end
end
