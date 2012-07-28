class UsersTagsRelationshipsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js

  def create
    @user = UserProfileInterface.new(current_user)
    @tags = params[:users_tags_relationship][:tags]
    # Maybe tag! should take an array as an argument ?
    @user.tag!(@tags)
    @tags = @tags.split(',').map(&:strip)
  end

  def destroy
    @user = UserProfileInterface.new(current_user)
    @user.untag!(params[:id])
  end
end
