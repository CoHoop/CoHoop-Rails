require 'modules/user_presenter'

class UserFeedPresenter < ApplicationPresenter
  include UserPresenter

  # Public: displays all community's urgent microhoops
  #
  # Returns an HTML String.
  def urgent_microhoops
    wrap_in(:ul, class: %(urgent microhoop)) do
      feed.content(:urgent).each do |microhoop|
        user = UserFeedPresenter(UserInterface.new(microhoop.user))
        render partial: 'users/feed/microhoop', locals: { user: user, microhoop: microhoop }
      end
    end
  end

  # Public: displays all community's microhoops
  #
  # Returns an HTML String.
  def all_microhoops
  end

  private
  def feed
    model
  end
end
