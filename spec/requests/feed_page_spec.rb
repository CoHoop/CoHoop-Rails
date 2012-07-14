require 'spec_helper'

describe "Feeds" do
  let(:user) { FactoryGirl.create :user }
  subject { page }
  before do
    sign_in_as user
    visit root_path
  end

  describe "Feed page" do
    it "should be the route path if the user is signed in" do
      should have_selector('title', content: 'News')
    end
  end
end
