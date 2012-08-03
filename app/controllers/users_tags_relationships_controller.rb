class UsersTagsRelationshipsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js

  # Creates new relationships between a user and tags
  def create
    @user = UserProfileInterface.new(current_user)
    @tags = params[:tags].downcase

    # OPTIMIZE: Maybe tag! should take an array as an argument ?
    @error = @user.tag!(@tags, main: params[:main].to_bool)

    # Turns "1,   2  , 3, 4, 5  " into #=> ['1', '2', '3', '4', '5']
    @tags  = @tags.split(',').to_set.map(&:strip)
    @main  = params[:main]
  end # View parameters : @user, @tags, @main

  # Destroys a relationship between a user and a tag
  def destroy
    @user = UserProfileInterface.new(current_user)
    @user.untag!(params[:id])

    @main = params[:main]
  end # View parameters : @user, @main
end
