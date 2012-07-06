require 'spec_helper'

describe UserProfilePresenter do
  include ActionView::TestCase::Behavior
  it 'bla' do
    presenter = UserProfilePresenter.new(User.new, view)
    pending 'Should make tests'
  end
end