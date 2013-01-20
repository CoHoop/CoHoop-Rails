class RelationshipsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js

  def create
    @user = UserProfileInterface.new(User.find(params[:relationship][:followed_id]))
    p @user
    current_user.follow!(@user)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
