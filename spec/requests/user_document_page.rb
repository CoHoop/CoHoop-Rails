require 'spec_helper'

describe 'User document pages' do
  let(:user) { FactoryGirl.create :user }
  subject { page }

  describe 'with a wrong user' do
    it 'should render 404 page' do
      visit(user_documents_path(id: 1, first: 'firstname', last: 'last'))
      status_code.should be '404'
      should have_selector('title', text: '404')
    end
  end

  describe 'with a correct user' do
    before do
      visit(user_documents_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase))
    end
    it { should have_selector('text', text: "CoHoop | Documents") }
  end
end
