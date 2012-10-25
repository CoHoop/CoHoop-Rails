require 'modules/user_presenter'

class UserProfilePresenter < ApplicationPresenter
  include UserPresenter

  def university
    handles_not_set user.university, check: true do |university|
      best_in_place_if(can_edit?, user, :university, type: :input, :nil => 'University not specified', errors: university.errors)
    end
  end

  def job
    handles_not_set user.job, check: true do |job|
      best_in_place_if(can_edit?, user, :job, type: :input, :nil => 'Job not specified', errors: job.errors)
    end
  end

  # Public: Renders user's biography wrapped in an editable span
  # (if the current user has the rights).
  #
  # Returns an HTML String.
  def biography
    handles_not_set user.biography, check: true do |biography|
      best_in_place_if(can_edit?, user, :biography, type: :textarea ,:nil => 'Biography not specified', errors: biography.errors)
    end
  end

  # TODO : Doc
  def manage_avatar
    if can_edit?
      render partial: 'users/profile/avatar_with_upload', locals: { presenter: self }
    else
      avatar(:huge)
    end
  end

  # TODO: Doc
  def avatar_form
    if can_edit?
      render partial: 'users/profile/avatar_form', locals: { user: user }
    end
  end

  # Public: displays a list of followers for the users
  #
  # Returns an HTML String.
  def followers_list
    render partial: 'users/profile/followers', locals: { user:  self }
  end

  # Private: Wraps user.followers inside presenters
  #
  # Returns an Array of followers.
  def followers
    # OPTIMIZE: Should be lazy
    user.followers.map { |f| self.class.new(f, helper) }
  end

  # Public: displays a list of followed users for the users
  #
  # Returns an HTML String.
  def followed_users_list
    render partial: 'users/profile/followed_users', locals: { user: self }
  end

  # Private: Wraps user.followed_users inside presenters
  #
  # Returns an Array of followed users.
  def followed_users
    # OPTIMIZE: Should be lazy
    user.followed_users.map { |f| self.class.new(f, helper) }
  end

  # Public: displays a follow or unfollow button
  #         if we are not on the current user's profile
  #
  # Returns an HTML String.
  def follow_button
    if is_not_current_user_profile?
      if current_user.following? user
        render partial: 'users/profile/unfollow', locals: { user: user }
      else
        render partial: 'users/profile/follow', locals: { user: user }
      end
    end
  end

  ## Tag Display

  # Public: displays a form for adding main tags
  #
  # Returns an HTML String.
  def add_main_tags
    if is_current_user_profile?
      render partial: 'users/profile/add_tags', locals: { user: user, is_main: true }
    end
  end

  # Public: displays all users main tags
  #
  # Returns an HTML String.
  def main_tags
    if is_current_user_profile?
      render partial: 'users/profile/main_tags_editable', locals: { user: user }
    else
      render partial: 'users/profile/main_tags', locals: { user: user }
    end
  end

  # Public: displays a form for adding secondary tags
  #
  # Returns an HTML String.
  def add_secondary_tags
    if is_current_user_profile?
      render partial: 'users/profile/add_tags', locals: { user: user, is_main: false }
    end
  end

  # Public: displays all users secondary tags
  #
  # Returns an HTML String.
  def secondary_tags
    if is_current_user_profile?
      render partial: 'users/profile/secondary_tags_editable', locals: { user: user }
    else
      render partial: 'users/profile/secondary_tags', locals: { user: user }
    end
  end

  def user_documents_path
    _.user_documents_path(id: user.id, first: user.first_name.downcase, last: user.last_name.downcase)
  end

  private
    # Public: A little helper for the best_in_place_if method, handling errors.
    #
    # TODO : ON DOUBLE CLICK, We want user to be able to select text without editing
    #
    # Returns an HTML String.
    def best_in_place_if(condition, model, method, *opts)
      options = opts.extract_options!
      if options[:errors]
        _.best_in_place_if(condition, model, method, display_with: options[:display_with], :nil => options[:nil], type: options[:type], classes: options[:errors])
      else
        _.best_in_place_if(condition, model, method, display_with: options[:display_with], :nil => options[:nil], type: options[:type], classes: options[:errors])
      end
    end

    def is_current_user_profile?
      _.user_signed_in? && can_edit?
    end

    def is_not_current_user_profile?
      _.user_signed_in? && !can_edit?
    end
end
