# Public: Wraps a model around a Presenter,
# providing methods for the display to the view
class ApplicationPresenter
  include ActiveSupport::Inflector

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
  # Returns a template Object.
  def _
    @template
  end

  # Public: Specific accessor for the model, allowing Presenters to get data.

  # Public: Generic accessor for the model, allowing Presenters to get data.
  # More specific model accessor are generated based on the controller name.
  #
  # Examples
  #
  #  # If we have a UserController and a user_name method in the model
  #  model.user_name # => Firstname Lastname
  #  user.user_name  # => Firstname Lastname
  #
  #  # If we have a FeedController and a first_microhoop method in the model
  #  model.first_microhoop # => <Microhoop instance>
  #  feed.first_microhoop  # => <Microhoop_instance>
  #
  # Returns a model Object.
  def model
    @model
  end

  # Public: Checks if the current user has edition rights
  #
  # Returns a Boolean.
  def can_edit?
    _.can? :update, model
  end

  # Public: Generates a tag
  #  with error classes if the object returns error classes.
  #
  # tag    - the designated tag to generate, as a Symbol.
  # object - The object to display.
  # opts   - A Hash containing options to apply to the tag.
  #
  # Returns an HTML String.
  def tag_with_error(tag, object, opts = {})
    options = {}
    # Retrieve the error_classes through the model. This attribute must be set.
    # See UserDecorator#error_classes.
    options[:class] = model.error_classes
    _.content_tag tag, object, options.deep_merge(opts)
  end

  # Public : Missing doc
  #
  # TODO: [doc]
  def handles_not_set(*objects)
    opts = objects.extract_options!
    opts[:check] ||= false

    o = []
    objects.each do |object|
      # FIXME: Only the first object errors are returned
      attr = OpenStruct.new
      if opts[:check] && can_edit?
        # Retrieve the error_classes through the model. This attribute must be set.
        # See UserDecorator#error_classes.
        attr.errors = model.error_classes
      else
        attr.errors = []
      end
      attr.content = object
      o << attr
    end
    yield *o
  end

end
