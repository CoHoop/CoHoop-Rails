class UsersController < ApplicationController
  include DisplayCase::ExhibitsHelper

  def show
    @user            = get_user_through_params || return
    @title = @user.user_name
  end

  private
    # Private: get the designated user through the following parameters
    #   :id for id, :first for first_name, :last for last_name.
    #   Redirect to 404 not found if the user does not exist
    #
    # It returns a UserExhibit or Nothing.
    def get_user_through_params
      user_query = User.where("id = ? AND first_name = ? AND last_name = ?", params[:id], params[:first].capitalize, params[:last].capitalize).first
      if user_query.nil?
        render_404 { flash[:alert] = 'User does not exist' }
      else
        @user = exhibit(user_query)
      end
    end
end

