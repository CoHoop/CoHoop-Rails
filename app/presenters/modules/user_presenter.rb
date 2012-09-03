module UserPresenter
  # Public: Get the user name through the associated model
  #
  # Returns a String.
  def name
    model.name
  end

  # Public: Creates a thumbnail for the user's avatar
  #
  # Returns an HTML String.
  def avatar
    _.image_tag model.avatar.url(:thumb), class: 'avatar', alt: self.name
  end
end
