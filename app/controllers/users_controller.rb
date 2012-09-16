class UsersController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!, only: [:update]

  def show
    @user  = get_user_through_params || return
    @title = @user.name
  end

  def update
    @user               = User.find(params[:id])
    is_uploading_avatar = params[:user].delete :avatar_upload_form

    if @user.update_attributes(params[:user])
      respond_with(@user) do |f|
        f.html { redirect_to current_user_profile_path }

        if is_uploading_avatar && remotipart_submitted?
          # As remotipart is only used for the avatar upload here, we can be
          # confident about the notice.
          f.js { js_redirect_to(current_user_profile_path) { flash[:notice] = 'Avatar modified successfully.' } }
        elsif is_uploading_avatar # If the user is submitting a blank upload form
          f.js
        end
      end # respond_with(@user)
    else
      respond_with(@user) do |f|
        f.js if remotipart_submitted?
      end
    end
  end
end
