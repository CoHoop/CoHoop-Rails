require 'spec_helper'

describe Tag do
  let(:tag) { FactoryGirl.create :tag }
  subject { tag }

  it { should respond_to(:name) }

  it { should be_valid }

  describe 'validation' do
    describe 'when name' do
      describe 'is not present' do
        before { tag.name = '' }
        it { should_not be_valid }
      end
      describe 'already exists' do
        before do
          @tag_copy = Tag.new(name: tag.name)
        end
        it { @tag_copy.should_not be_valid }
      end
    end
  end
end
