module ApplicationHelper
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

  ## Used by devise to generate views
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  #

  # Public: display an inline user authentication interaction
  #
  # Returns the generated html String.
  def display_user_authentication
    if user_signed_in?
      render 'devise/menu/logged_in_links'
    else
      render 'devise/menu/login_form'
    end
  end

  def current_user_profile_path
    profile_path(id: current_user.id,
                 first: current_user.first_name.downcase,
                 last: current_user.last_name.downcase)
  end
end
