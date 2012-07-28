require 'spec_helper'

describe UsersTagsRelationshipsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:tags) { 'Hello, Foo, Bar' }

  # From Devise::TestHelpers
  before { sign_in user }

  describe 'creating user/tags relationships asynchronously' do
    it { expect { xhr :post, :create, users_tags_relationship: { tags: tags } }.to change(UsersTagsRelationship, :count).by(3) }
  end

  describe 'destroying a user/tag relationship asynchronously' do
    before do
      user.tag!(tags)
    end
    let(:tag) { user.tags.first }
    it { expect { xhr :delete, :destroy, id: tag.id }.to change(UsersTagsRelationship, :count).by(-1) }
  end
end
