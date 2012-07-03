require 'spec_helper'

describe 'All static pages :' do

  # TODO: Should refactor this
  shared_examples_for "all pages" do
    describe 'should have a correct title' do
      it { should have_selector('title', content: "CoHoop | #{page_title}") }
    end
  end

  describe 'landing page' do
    let(:page_title) { 'Home' }
    before { visit root_path }
    subject { page }

    it_should_behave_like 'all pages'

    it 'should have a register link' do
      should have_link 'home-register-link', href: new_user_registration_path
    end

    it 'should have a connection form' do
      should have_selector 'form', id: 'login-mini-form'
    end
  end

end
