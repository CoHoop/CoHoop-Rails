require 'modules/user_presenter'

class UserProfilePresenter < ApplicationPresenter
  include UserPresenter

  # Public: Renders users's university and job wrapped in h2 tags.
  #
  # Returns an HTML String.
  def professional_information
    handles_not_set user.university, user.job, check: true do |university, job|
      best_in_place_if(can_edit?, user, :university, type: :input, :nil => university.content, errors: university.errors) +
      best_in_place_if(can_edit?, user, :job, type: :input, :nil => job.content, errors: job.errors)
    end
  end

  # Public: Renders user's biography wrapped in a p tag.
  #
  # Returns an HTML String.
  def biography_paragraph
    handles_not_set user.biography, check: true do |biography|
      best_in_place_if(can_edit?, user, :biography, type: :input, :nil => biography.content, errors: biography.errors)
    end
  end

  def wrap_in(tag, *options)
    options = options.extract_options!
    _.content_tag(tag, yield, options)
  end

  private
    def best_in_place_if(condition, model, method, *opts)
      options = opts.extract_options!
      if options[:errors]
        wrap_in(:span, class: options[:errors]) do
          _.best_in_place_if(can_edit?, model, method, :nil => options[:nil], type: options[:type])
        end
      else
        _.best_in_place_if(can_edit?, model, method, :nil => options[:nil], type: options[:type])
      end
    end
end