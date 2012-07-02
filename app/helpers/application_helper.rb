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
end
