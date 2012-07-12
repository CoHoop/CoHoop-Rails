require 'spec_helper'

describe 'User profile page avatar uploading' do
  let(:user) { FactoryGirl.create :user }
  subject { page }

  it 'should not do anything if the user is not logged in' do
    visit(profile_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))
    should_not have_css('#avatar-menu')
  end

  describe 'when clicking on the avatar' do
    before do
      sign_in_as user
      visit(profile_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))

      click_link 'avatar-dropdown'
    end
    it 'should display a dropdown-menu', js: true do
      should have_css('.dropdown-menu', visible: true)
    end

    describe 'the dropdown menu' do
      it 'should show an upload link', js: true do
        should have_css('#upload-avatar', visible: true)
      end

      describe 'when upload link is clicked', js: true do
        before { click_link 'upload-avatar' }
        it 'should display a pop-in containing an upload form' do
          should have_css('#upload-popin #avatar-upload-form', visible: true)
        end

        describe 'when the form is submitted' do
          let(:fixtures_path) { [Rails::root, 'spec', 'fixtures'] }

          describe 'with a valid file' do
            it 'should upload it and be successful' do
              path = File.join(fixtures_path, 'images', 'avatar.png') # REFACTOR
              attach_file('avatar-input', path)
              click_button 'Upload'
              should have_content('success')
            end
          end # with a valid file

          describe 'without any file' do
            it 'should display an error in the pop-in' do
              click_button 'Upload'
              pending 'How to implement this ?'
              #should have_css('#upload-popin .errors_explanation', content: 'The file is missing')
            end
          end # without any file

          describe 'with an invalid file' do
            describe 'format' do
              it 'should display an error in the pop-in' do
                path = File.join(fixtures_path, 'others', 'sound.ogg') # REFACTOR
                attach_file('avatar-input', path)
                click_button 'Upload'
                should have_css('#upload-popin .errors_explanation', content: 'format is invalid')
              end
            end

            describe 'size' do
              it 'should display an error in the pop-in' do
                path = File.join(fixtures_path, 'images', 'big.jpeg') # REFACTOR
                attach_file('avatar-input', path)
                click_button 'Upload'
                should have_css('#upload-popin .errors_explanation', content: 'file size exceeded')
              end
            end
          end # with an invalid file

        end # when the form is submitted
      end # upload option is selected
    end # dropdown
  end # clicking on the avatar
end