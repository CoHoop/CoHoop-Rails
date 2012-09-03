class MicrohoopsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js

  def create
    urgent  = params[:microhoop][:urgent].to_bool # Expects urgent to be String or Numeric
    content = params[:microhoop][:content]
    @microhoop = current_user.microhoops.create!(content: content, urgent: urgent)
    @user = UserFeedPresenter.new(UserFeedInterface.new(@microhoop.user), view_context)
  end
end
