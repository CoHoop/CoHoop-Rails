# Public: Wraps a model around a Presenter, providing methods for display to
# the view.
# Presenters are Proxies, they do not delegate anything to the underlying model.
# Please give a look a the {PresenterHelper} class to help you with view
# integration.
class ApplicationPresenter
  include ActiveSupport::Inflector

  delegate :render, :current_user, to: :helper

  # A new instance of ApplicationPresenter
  #
  # model    - The model to present.
  # template - The template with which we want to present. It will allow access
  #            to helpers methods from the Presenter.
  #
  # Examples
  #
  #   # A typical example in a controller would be :
  #   ApplicationPresenter.new(User.find(params[:id]), view)
  def initialize(model, template)
    @model    = model
    @template = template
    @model_name = @template.controller_name.singularize
    self.class.send(:define_method, @model_name) do
      @model
    end
  end

  # Public: Alias for the template object, allowing Presenters to call helpers.
  #
  # Examples
  #
  #   # All three will create an html tag in the exact same way.
  #   helper.content_tag(:div)
  #   h.content_tag(:p)
  #   _.content_tag(:span)
  #
  # Returns a template Object.
  def helper
    @template
  end
  alias :_ :helper
  alias :h :helper

  # Public: Generic accessor for the model, allowing Presenters to get data.
  # More specific model accessor are generated based on the controller name.
  #
  # Examples
  #
  #   # If we have a UserController and a user_name method in the model
  #   model.user_name # => Firstname Lastname
  #   user.user_name  # => Firstname Lastname
  #
  #   # If we have a FeedController and a first_microhoop method in the model
  #   model.first_microhoop # => <Microhoop instance>
  #   feed.first_microhoop  # => <Microhoop_instance>
  #
  # Returns a model Object.
  def model
    @model
  end


  # Public: Checks if the model has authentication capabilities.
  # If it has none, by default, it means we do not care about authentication,
  # and it will always return true.
  #
  # default - A Boolean indicating if we should care about authentication when
  #           it is not set (default: true).
  #
  # REFACTOR : May be refactored in the ModelInterface or the AuthenticationInterface.
  #
  # Returns a Boolean.
  def can_edit?(default = true)
    if model.respond_to?(:can?)
      model.can_edit?
    else
      default
    end
  end

  # Public : Wraps a string in an html tag, via the rails content_tag helper.
  #
  # tag     - The wrapping tag, as a Symbol.
  # options - A Hash of options to be passed to content_tag.
  # block   - The code to be wrapped in, should return a String.
  #
  # Examples
  #
  #   wrap_in(:div, class: %(well blank)) do
  #     _.content_tag(:strong, 'Hello') +
  #     _.content_tag(:em, 'World')
  #   end
  #
  # Returns an HTML String.
  def wrap_in(tag, *options, &block)
    options = options.extract_options!
    _.content_tag(tag, block.call, options)
  end


  # Public : Handles the case where an object has no value or has been set to
  # something like 'Attribute not specified'.
  #
  # objects - Objects to handle.
  # objects - The last argument of the method can be a hash containing options.
  #           :check - A boolean indicating if current user authentication has
  #                    to be checked. (optional) (default: false)
  #
  # Yields an OpenStruct with two attributes :
  #        content - The content of the object, as a String.
  #                  Automatically set to 'Not specified' if the original value was blank or matching /not specified/.
  #        errors  - An Array of errors as Strings.
  #
  # Examples
  #
  #   # We have here a user.university attribute set to 'MIT'
  #   # We have here a user.job attribute set to ''
  #   # We have here a user.email attribute set to 'Email not specified'
  #
  #   handles_not_set user.university, user.job, user.email do |university, job, email|
  #     university.content # => MIT
  #     university.errors  # => []
  #     job.content        # => 'Not specified'
  #     job.errors         # => ['blank']
  #     email.content      # => 'Email not specified'
  #     email.errors       # => ['blank']
  #   end
  #
  #   # If the user doesn't have the rights, it content and errors are not handled.
  #   handles_not_set user.university, user.job, check: true do |u, j|
  #     _.content_tag(:strong, u.content, class: u.errors) +
  #     _.content_tag(:em, j.content, class: j.errors)
  #   end
  #   # If user hasn't got the rights
  #   # <strong>MIT</strong><em></em>
  #   # If user has the rights
  #   # <strong>MIT</strong><em class="blank">Not specified</em>
  #
  # TODO : Should handle more cases than just /not specified/
  #
  # Returns an HTML String.
  def handles_not_set(*objects)
    opts = objects.extract_options!
    opts[:check] ||= false
    o = []
    objects.each do |object|
      attr = OpenStruct.new
      attr.errors = []
      if opts[:check] && can_edit?
        attr.content = (!object.blank?) ? object : 'Not specified'
        attr.errors << 'blank' if (object.blank? || object[/not specified/])
      else
        attr.content =  object
      end
      o << attr
    end
    yield *o
  end

end
