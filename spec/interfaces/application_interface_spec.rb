require "spec_helper"

describe ModelInterface do
  let(:user) { FactoryGirl.create(:user) }
  let(:interface) { ModelInterface.new(user) }
  subject { interface }

  it { should.respond_to? :model }
  it '#model' do
    interface.model.should == user
  end
end