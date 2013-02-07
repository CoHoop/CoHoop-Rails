module ApplicationHelper
  include PresenterHelper

  # Public: generate a title for the current page
  #
  # title - A title for the page (default: current action name)
  #
  # Returns the full title as a String.
  def get_title(title)
    application_name = 'CoHoop'
    title = action_name.capitalize if title.nil?
    (action_name.nil? && title.nil?) ? application_name : "#{application_name} | #{title}"
  end

  # Public: Used by devise to generate views
  def resource_name
    :user
  end

  # Public: Used by devise to generate views
  def resource
    @resource ||= User.new
  end

  # Public: Used by devise to generate views
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  #

  # Public: Display an inline user authentication interaction
  #
  # Returns the generated html String.
  def display_user_authentication
    if user_signed_in?
      render 'devise/menu/logged_in_links'
    else
      #render 'devise/menu/login_form'
    end
  end

  # Public: Returns the current user profile path
  #
  # Examples
  #
  #  current_user_profile_path
  #  # => /1/user-name
  #
  # Returns the path as a String.
  def current_user_profile_path
    profile_path(id: current_user.id,
                 first: current_user.first_name.downcase,
                 last: current_user.last_name.downcase)
  end
end
