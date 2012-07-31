module UserPresenter
  # Public: Get the user name through the associated model
  #
  # Returns a String.
  def name
    model.name
  end
end
