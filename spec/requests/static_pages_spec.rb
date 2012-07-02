require 'spec_helper'

describe 'All static pages :' do
  subject { page }

  # TODO: Should refactor this
  shared_examples_for "all pages" do
    describe 'should have a correct title' do
      it { page.should have_selector('title', content: "CoHoop | #{page_title}") }
    end
  end

  describe 'landing' do
    before { visit root_path }
    let(:page_title) { 'Home' }

    it_should_behave_like 'all pages'
  end

end
