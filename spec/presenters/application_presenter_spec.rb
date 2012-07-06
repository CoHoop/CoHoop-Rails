require 'spec_helper'

# Here we will use a fake decorator to handle model behavior
class FakeDecorator < ApplicationDecorator
  decorates :user
  def university; may_not_be_specified :university end
  def job;        may_not_be_specified :job end
end

describe ApplicationPresenter do
  #include ActionView::TestCase::Behavior
  describe '#handles_not_set' do
    before do
      # We use a decorator to be sure we have error_classes set
      @user = FakeDecorator.decorate(FactoryGirl.create(:user))
      @presenter = ApplicationPresenter.new(@user, view)
    end
    it 'should yield OpenStructs' do
      @presenter.handles_not_set @user.university, @user.job do |university, job|
        university.class.should == OpenStruct
        job.class.should        == OpenStruct
      end
    end
    describe 'may check the rights for an attribute' do
      it 'and include errors if the rights are rights' do
        #sign_in_as user
        @presenter.handles_not_set @user.university, @user.job, check: true do |university, job|
          university.errors.should == %w(university blank)
          job.errors               == %w(job blank)
        end
      end

      it 'and not include errors if the rights are wrong' do
        @presenter.handles_not_set @user.university, @user.job, check: true do |university, job|
          university.errors.should == []
          job.errors.should == []
        end
      end
    end # May check the rights for an attribute

  end # handles_not_set
end