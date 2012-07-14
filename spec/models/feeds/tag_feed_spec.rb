require 'spec_helper'

describe TagFeed do
  pending 'Need to implement tags'

  let(:user) { FactoryGirl.create :user }
  let(:feed) { TagFeed.new(user) }
  subject { feed }

  its(:type) { should == :tag }

  it "should get tag related microhoops" do end
  describe "when getting activities" do
    pending 'Need to implement activities'
    describe 'from users with related tags' do end
    describe 'from documents with related tags' do end
  end

end

