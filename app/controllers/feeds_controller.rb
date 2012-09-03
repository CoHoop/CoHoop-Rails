class FeedsController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_user!, only: [:show]

  def show
    @title  = 'News'
    generate_feed
  end

  def filter
    generate_feed
    @feed.filter = params[:feed][:filter].to_sym
    @presenter = UserFeedPresenter.new(@feed, view_context)
    respond_with(@feed) do |f|
      f.js
    end
  end

  private
    def generate_feed
      page = params[:page] || 1
      type = params[:feed_type] || :community
      # TODO: Switch to microhoops & activities when activities are implemented
      @user = UserFeedInterface.new(current_user)
      @feed = @user.build_feed(page, type)
    end
end
