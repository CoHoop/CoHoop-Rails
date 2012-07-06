class UsersController < ApplicationController

  def show
    @user  = get_user_through_params || return
    @title = @user.user_name
  end

  private
    # Private: get the designated user through the following parameters
    #  :id for id, :first for first_name, :last for last_name.
    #  Render a 404 not found if the user does not exist.
    #
    # Returns a UserProfileDecorator or Nothing.
    def get_user_through_params
      model_object = User.where("id = ? AND first_name = ? AND last_name = ?", params[:id], params[:first].capitalize, params[:last].capitalize).first
      if model_object.nil?
        render_404 { flash[:alert] = 'User does not exist' }
      else
        UserProfileDecorator.decorate(model_object)
      end
    end
end

