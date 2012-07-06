module UserPresenter
  # Public: Get the user name through the associated model
  #
  # Returns a String.
  def user_name
    model.user_name
  end
end