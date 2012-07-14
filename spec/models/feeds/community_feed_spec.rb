require 'spec_helper'

describe CommunityFeed do
  pending 'Need to implement following/follower system'

  let(:user) { FactoryGirl.create :user }
  let(:feed) { CommunityFeed.new(user) }
  subject { feed }

  its(:type){ should == :community }

  it "should get its community microhoops" do  end

  describe "when getting activities" do
    pending 'Need to implement activities'
    describe "from followed user's'" do end
    describe "from followed user's documents" do end
  end
end

