require 'spec_helper'
require_relative '../../app/helpers/presenter_helper'

describe ApplicationHelper do
  describe 'when using presenters' do
    describe '#present' do
      before do
        class Helper; end
        class TestPresenter; def initialize a, b; end end
        class HelperTestPresenter; def initialize a, b; end end
      end
      it 'should return a presenter object' do
        present(Helper.new, presenter: :test).class.should == TestPresenter
        present(Helper.new, presenters: [:helper, :test]).class.should == HelperTestPresenter
      end
    end # #present
  end # when using presenters
end