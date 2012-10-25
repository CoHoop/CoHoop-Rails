module UserPresenter
  # Public: Get the user name through the associated model
  #
  # Returns a String.
  def name
    model.name
  end

  def current_user_profile_link
    _.profile_path(id: current_user.id, first: current_user.first_name.downcase, last: current_user.last_name.downcase)
  end

  # Public: Creates a thumbnail for the user's avatar
  #
  # Returns an HTML String.
  def avatar
    _.image_tag model.avatar.url(:thumb), class: 'avatar', alt: self.name
  end
end
