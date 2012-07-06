module UserPresenter
  # Public: Get the user name through the associated model
  #
  # Returns a String.
  def user_name
    model.user_name
  end

  # Public: Checks if the current user can edit the user resource
  #
  # Returns a Boolean.
  def can_edit?
    _.can? :update, User
  end
end