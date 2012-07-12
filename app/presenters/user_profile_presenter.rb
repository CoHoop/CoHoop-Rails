require 'modules/user_presenter'

class UserProfilePresenter < ApplicationPresenter
  include UserPresenter

  # Public: Renders users's university and job wrapped in an editable span
  # (if the current user has the rights).
  #
  # Returns an HTML String.
  def professional_information
    handles_not_set user.university, user.job, check: true do |university, job|
      best_in_place_if(can_edit?, user, :university, type: :input, :nil => 'University not specified', errors: university.errors) +
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

  def avatar
    _.image_tag user.avatar.url(:thumb), class: 'avatar'
  end

  def manage_avatar
    if can_edit?
      _.render partial: 'users/profile/avatar_with_upload', locals: { presenter: self }
    else
      avatar
    end
  end

  def avatar_form
    if can_edit?
      _.render partial: 'users/profile/avatar_form', locals: { user: user }
    end
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
end