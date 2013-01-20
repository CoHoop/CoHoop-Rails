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
  # size - the size as a Symbol (default: :big)
  #
  # Returns an HTML String.
  def avatar(size = :big)
    _.image_tag model.avatar.url(size), class: 'avatar', alt: self.name
  end

  def id; model.id; end
  def first_name; model.first_name; end
  def last_name; model.last_name; end
end
