require 'spec_helper'

describe RelationshipsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  # From Devise::TestHelpers
  before { sign_in user }

  describe 'creating a relationship asynchronously' do
    it { expect { xhr :post, :create, relationship: { followed_id: other_user.id } }.to change(Relationship, :count).by(1) }
  end

  describe 'destroying a relationship asynchronously' do
    before { user.follow!(other_user) }
    let(:relationship) { user.relationships.find_by_followed_id(other_user) }
    it { expect { xhr :delete, :destroy, id: relationship.id  }.to change(Relationship, :count).by(-1) }
  end
end
