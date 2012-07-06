require 'modules/user_presenter'

class UserProfilePresenter < ApplicationPresenter
  include UserPresenter

  # Public: Renders users's university and job wrapped in h2 tags.
  #
  # Returns an HTML String.
  def professional_information
    tag_with_error(:h2, user.university) + tag_with_error(:h2, "Works at #{user.job}")
  end

  # Public: Renders user's biography wrapped in a p tag.
  #
  # Returns an HTML String.
  def biography_paragraph
    tag_with_error(:p, user.biography)
  end
end