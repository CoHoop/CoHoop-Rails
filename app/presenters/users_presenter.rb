require 'modules/user_presenter'

class UsersPresenter < ApplicationPresenter
  include UserPresenter

  def list_all_users
    # TODO: Should make UserPresenter a class not a module, so we don't need to user UsersProfilePresenter
    all_users = users.map { |u| UserProfilePresenter.new(UserInterface.new(u), helper) }
    render partial: 'users/shared/list', locals: { users: all_users }
  end

  def users
    model
  end

end
