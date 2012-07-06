require 'spec_helper'

describe "UserDecorator" do
  let(:user) { UserDecorator.decorate(FactoryGirl.create :user) }
  subject { user }

  it { should respond_to :user_name }

  describe "#user_name" do
    it 'should return the user name' do
      user.user_name.should == 'Firstname Lastname'
    end
  end
end