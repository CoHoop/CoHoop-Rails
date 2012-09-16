require 'spec_helper'

describe 'Documents pages' do
  describe 'Display document' do
    let(:document_id) { 'foobar' }
    subject { page }

    before {
          visit documents_path(id: document_id)
    }

    it 'should get the page' do
      page.status_code.should be 200
    end
    # TODO: Should be refactored
    it { should have_selector('title', text: document_id) }

    describe "Contain the document the document's id" do
      it { should have_css("#document[data-id='#{document_id}']") }
    end
  end
end
