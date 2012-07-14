require 'spec_helper'

describe Feed do
  let(:user) { FactoryGirl.create :user }
  let(:feed) { Feed.new(user) }
  subject { feed }

  it "should belong to a user" do
    feed.user.should == user
  end

  it 'should have a type ' do
    should respond_to :type
  end

  describe 'should be able to get content to hydrate itself' do
    describe 'from activities and microhoops' do
      pending 'Need to implement activities & following system'
    end

    describe 'and filter it' do
      specify 'by activities' do end
      specify 'by microhoops' do end
      specify 'by urgent microhoops' do end
    end
  end # should be able to get content
end

