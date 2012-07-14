require 'spec_helper'
require_relative '../../app/helpers/presenter_helper'

describe ApplicationHelper do
  describe 'when using presenters' do
    describe '#present' do
      before do
        TestModel.stub(:new)
        @presenter = stub
        [TestPresenter, OtherTestPresenter].each do |presenter_class|
          presenter_class.stub(:new).with(any_args()).and_return @presenter
        end
      end
      it 'should return a presenter object' do
        expect { |b| present(TestModel.new, presenter: :test, &b) }.to yield_with_args(@presenter)
        expect { |b| present(TestModel.new, presenters: [:other, :test], &b) }.to yield_with_args(@presenter)
      end
    end # #present
  end # when using presenters
end

class TestModel; end
class TestPresenter; end
class OtherTestPresenter; end
