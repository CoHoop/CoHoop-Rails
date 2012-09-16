require 'spec_helper'

describe 'User pages :' do
  let(:user) { FactoryGirl.create :user_with_avatar }
  let(:other_user) { FactoryGirl.create :user }

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
        visit(profile_path(id: 1, first: 'firstname', last: 'last'))
        should have_selector('title', content: '404')
      end
    end

    describe 'with a correct user' do
      before do
        visit(profile_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))
      end

      let(:page_title) { user.first_name.capitalize + ' ' + user.last_name.capitalize }
      it_should_behave_like 'all user pages'

      describe 'should display the user name' do
        it { should have_selector('h1', content: 'Firstname Lastname' ) }
      end

      describe 'the follow button' do
        before { other_user.follow! user }
        describe 'if the user is not logged in' do
          it { should_not have_button "Follow" }
        end
        describe 'if the user is logged in' do
          before do
            sign_in_as user
            visit(profile_path(id: other_user.id, first: other_user.first_name.downcase, last: other_user.last_name.downcase))
          end
          it { should have_button "Follow" }
        end # if the user is logged in
      end # the follow button

      describe 'should display the avatar' do
        it 'should display a default image if the user has not specified one' do
          user.avatar = nil
          user.save!
          visit(profile_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))

          should have_xpath( '//img[contains(@src, "missing")]' )
        end
        it 'should display an avatar if the user has one' do
          should_not have_xpath( '//img[contains(@src, "missing")]' )
          should have_selector("img[src$='#{user.avatar.url(:thumb)}']")
        end
      end
      describe 'should display a list of followers' do
        before do
          other_user.follow! user
          visit(profile_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))
          @name = "#{other_user.first_name.capitalize} #{other_user.last_name.capitalize}"
        end
        it { should have_selector("#followers ul li img", alt: @name ) }
     end
      describe 'should display a list of followed' do
        before do
          user.follow! other_user
          visit(profile_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))
          @name = "#{other_user.first_name.capitalize} #{other_user.last_name.capitalize}"
        end
        it { should have_selector("#followed-users ul li img", alt: @name ) }
      end

      describe 'should display social media links' do
        pending 'and should be tested'
      end
      describe 'may display a progress bar' do
        pending 'and should be tested'
      end
      describe 'should display the university' do
        it { should have_content(user.university) }
      end
      describe 'should display a job' do
        it { should have_content(user.job) }
      end
      describe 'should display a cursus' do
        pending 'and should be tested'
      end

      describe 'tags integration', js: true do
        before do
            sign_in_as user
        end
        describe 'add tag' do
          before do
            visit(profile_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))
          end
          describe 'main tags' do
            before do
              fill_in 'add-main-tag-field', with: 'My tag, Hello, World'
            end
            it 'should add the tags to the main tags' do
              click_on "add-main-tag"
              should have_selector("#main-tags-list li", text: 'My tag' )
              should have_selector("#main-tags-list li", text: 'Hello' )
              should have_selector("#main-tags-list li", text: 'World' )
            end
          end
          describe 'secondary tags' do
            before do
              fill_in 'add-secondary-tag-field', with: 'Foobar'
            end
            it 'should add the tags to the secondary tags' do
              click_on "add-secondary-tag"
              should have_selector("#secondary-tags-list li", text: 'Foobar' )
            end
          end
        end
        describe 'delete tag' do
          before do
            user.tag!('My tag', main: true);
            visit(profile_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))
          end
          it { expect { click_on "delete-my-tag" }.to change(user.tags, :count).by(-1) }
        end
        describe 'display tags' do
          before do
            user.tag!('My tag, Hello', main: true);
            user.tag!('Foo', main: false);
            user.tag!('Bar');
            visit(profile_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))
          end
          describe 'main tags' do
            it { should have_selector('#main-tags-list') }
            it { should have_selector("#main-tags-list li", text: 'My tag' ) }
            it { should have_selector("#main-tags-list li", text: 'Hello' ) }
          end
          describe 'secondary tags' do
            it { should have_selector('#secondary-tags-list') }
            it { should have_selector("#secondary-tags-list li", text: 'Foo' ) }
            it { should have_selector("#secondary-tags-list li", text: 'Bar' ) }
          end
        end
      end
      describe 'should display a biography' do
        pending 'and should be tested'
        it { should have_content(user.biography) }
      end
      describe 'should display a list of share documents' do
        pending 'and should be tested'
      end
      describe 'should display a list of favorite documents' do
        pending 'and should be tested'
      end
      describe 'should have a link to switch in document view mode' do
        it { should have_link('Documents', href: user_documents_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))}
      end
    end
  end
end
