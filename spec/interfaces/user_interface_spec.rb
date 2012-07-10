require 'spec_helper'

describe UserInterface do
  let(:user) { UserInterface.new(FactoryGirl.create :user) }
  subject { user }

  it { should respond_to :name }
  describe "#user_name" do
    it 'should return the user name' do
      user.name.should == 'Firstname Lastname'
    end
  end
end