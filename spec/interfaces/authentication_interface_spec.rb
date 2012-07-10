require 'spec_helper'

describe AuthenticationInterface do
  let(:user) { FactoryGirl.create(:user) }
  let(:interface) { AuthenticationInterface.new user, user }
  subject { interface }

  it 'should have #can? method' do
    interface.model.should == user
  end
  it { should respond_to(:can?) }
  it { should respond_to(:cannot?) }
  it { should respond_to(:ability) }
end