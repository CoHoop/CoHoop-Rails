require 'spec_helper'
require_relative '../../../app/exhibits/user_exhibit'

include DisplayCase::ExhibitsHelper

describe "User Exhibit" do
  let(:user) { exhibit(FactoryGirl.create :user) }
  subject { user }

  it { should respond_to :user_name }

  describe "#user_name" do
    it 'should return the user name' do
      user.user_name.should == 'FirstName LastName'
    end
  end
end