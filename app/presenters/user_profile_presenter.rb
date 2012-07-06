require 'modules/user_presenter'

class UserProfilePresenter < ApplicationPresenter
  include UserPresenter

  # Public: Renders users's university and job wrapped in h2 tags.
  #
  # Returns an HTML String.
  def professional_information
    handles_not_set user.university, user.job, check: true do |university, job|
      wrap_in(:div, class: university.errors) do
      _.best_in_place_if(can_edit?, user, :university, type: :input)
      end +
      wrap_in(:div, class: job.errors) do
        _.best_in_place_if(can_edit?, user, :job,      type: :input)
      end
      #if can_edit?
      #  _.best_in_place_if(university.content, class: university.errors) +
      #      _.content_tag(: "Works at #{job.content}", class: job.errors)
      #end
    end
  end

  # Public: Renders user's biography wrapped in a p tag.
  #
  # Returns an HTML String.
  def biography_paragraph
    handles_not_set user.biography, check: true do |biography|
      _.content_tag(:p, biography.content, class: biography.errors)
    end
  end

  def wrap_in(tag, *options)
    options = options.extract_options!
    _.content_tag(tag, yield, options)
  end
end