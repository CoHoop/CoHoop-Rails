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
        before do
          @other_user = FactoryGirl.create :user
          @mh0 = user.microhoops.create(content: 'Hello, world from myself.')
          @mh1 = @other_user.microhoops.create(content: 'Hello, world this is a feed.')
          @mh2 = @other_user.microhoops.create(content: 'Hello, world this is a urgent feed.', urgent: true)
          user.follow! @other_user
        end
        describe "displaying of all users's community microhoops" do
          it { should have_content(@mh0.content) }
          it { should have_content(@mh1.content) }
          it { should have_content(@mh2.content) }
          it 'should display urgent tags in a special way' do
            should have_selector('.urgent', text: @mh2.content)
          end
        end # community feed
      end # elements
    end
  end
end
