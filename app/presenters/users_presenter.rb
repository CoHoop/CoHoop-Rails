require 'modules/user_presenter'

class UsersPresenter < ApplicationPresenter
  include UserPresenter

  def list_all_users
    # TODO: Should make UserPresenter a class not a module, so we don't need to user UsersProfilePresenter
    # TODO: Should use a factory for Presenter and interfaces
    users.delete(current_user) if current_user
    all_users = users.map { |u| UserProfilePresenter.new(UserInterface.new(AuthenticationInterface.new(u, current_user)), helper) }
    render partial: 'users/shared/list', locals: { users: all_users, avatar_size: :medium }
  end

  def users
    model
  end

end
