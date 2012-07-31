class UsersTagsRelationshipsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js

  def create
    @user = UserProfileInterface.new(current_user)

    @tags = params[:tags].downcase
    # Maybe tag! should take an array as an argument ?
    @error = @user.tag!(@tags, main: params[:main].to_bool)
    @tags  = @tags.split(',').to_set.map(&:strip)
    @main  = params[:main]
  end

  def destroy
    @user = UserProfileInterface.new(current_user)
    @user.untag!(params[:id])
    @main = params[:main]
  end
end
