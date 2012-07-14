require 'spec_helper'

describe UserFeedInterface do
  let(:user) { UserFeedInterface.new(FactoryGirl.create :user) }
  subject { user }

  it { should respond_to :build_feed }
  it { should respond_to :feed }

  describe 'feed' do
    before { @feed = user.build_feed }
    its(:feed) { should be_kind_of Feed }
    it 'can build a feed' do
      @feed.should be_kind_of Feed
    end
  end
end