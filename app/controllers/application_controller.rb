class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActionController::RoutingError,      with: :render_404
  rescue_from ActionController::UnknownController, with: :render_404
  rescue_from AbstractController::ActionNotFound,  with: :render_404
  rescue_from ActiveRecord::RecordNotFound,        with: :render_404

  # Public: Redirect to a default page or back to another page.
  #
  # path - The String or the RouteName to which to go back to (default: nil).
  #
  # Returns nothing.
  def get_default_or_back_to path = nil
    # TODO: Should redirect to user feed
    path ||= root_path
    redirect_to path
  end

  private
    # Private: Renders the 404 page.
    #
    # &block - a Block which will be executed before rendering.
    #
    # Examples
    #
    #   render_404 { Flash[:alert] = 'User not found.' }
    #
    # Returns nothing.
    def render_404
      @title = 404
      yield
      respond_to do |format|
        format.html { render file: "#{Rails.root}/public/404", formats: [:html], status: 404 }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
      nil
    end

end
