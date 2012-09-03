require 'spec_helper'

describe MicrohoopsController do
  let(:user) { FactoryGirl.create(:user) }

  # From Devise::TestHelpers
  before { sign_in user }

  describe 'creating a microhoop asynchronously' do
    it { expect { xhr :post, :create, microhoop: { content: 'Foobar', urgent: 0 }, user_id: user.id }.to change(Microhoop, :count).by(1) }
  end

  describe 'creating an urgent microhoop asynchronously' do
    it { expect { xhr :post, :create, microhoop: { content: 'Foobar', urgent: 1 }, user_id: user.id }.to change(Microhoop, :count).by(1) }
  end
end
