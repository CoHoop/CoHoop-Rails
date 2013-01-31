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

      it { should have_selector('title', content: 'News') }

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
    end # can be accessed if

    describe 'feed elements' do
      before { sign_in_as user }

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
          visit root_path
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

      describe 'vote up microhoop button' do
        before do
          @mh = user.microhoops.create(content: 'Hello.')
          visit root_path
        end
        let (:vote_up_button) { "#microhoop-#{@mh.id} .vote_up" }

        it { should have_css(vote_up_button) }

        it 'should increment the microhoop vote count when clicked' do
          click_on vote_up_button
          @mh.vote_count.should == 1
        end
      end

      describe 'add microhoops' do
        it { should have_css('#new_microhoop') }
        describe 'remotely', js: true do
          let(:content) { 'This is a newly added microhoop' }
          before { fill_in 'microhoop_content', with: content }

          describe 'type: normal' do
            before { click_on "add-microhoop" }
            it { should have_content(content) }
          end

          describe 'type: urgent' do
            before do
              check 'microhoop_urgent'
              click_on "add-microhoop"
            end
            it { should have_css('.urgent', text: content) }
          end # type urgent

          describe 'with tag' do
            let(:content) { 'With #Tag1, #tag2, #3Tag' }
            before { click_on "add-microhoop" }
            it { should have_content(content) }
          end
        end # remotely
      end # add mh

      describe 'filters' do
        # TODO: Copy pasted, should be refactored !!
        before do
          @other_user = FactoryGirl.create :user
          @mh0 = user.microhoops.create(content: 'Hello, world from myself.')
          @mh1 = @other_user.microhoops.create(content: 'Hello, world this is a feed.')
          @mh2 = @other_user.microhoops.create(content: 'Hello, world this is a urgent feed.', urgent: true)
          user.follow! @other_user
          visit root_path
        end
        describe 'urgent microhoops' do
          let(:urgent_button) { 'Urgent' }
          it { should have_button urgent_button }
          describe 'remove all non urgent tags', js: true do
            before { click_on urgent_button }
            it { should_not have_content(@mh1.content) }
            it { should have_content(@mh2.content) }
          end
        end
      end # filters
    end
  end
end
