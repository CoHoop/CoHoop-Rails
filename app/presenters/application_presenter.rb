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

  # Checks if the model has authentication capabilities.
  # If it has none, it means we do not care about authentication.
  #
  # REFACTOR : Maybe refactored in the ModelInterface or the AuthenticationInterface.
  #
  # Returns TrueClass or FalseClass.
  def can_edit?
    if model.respond_to?(:can?)
      model.can_edit?
    else
      true
    end
  end

  # Public : Missing doc
  #
  # TODO: [doc]
  def handles_not_set(*objects)
    opts = objects.extract_options!
    opts[:check] ||= false
    o = []
    objects.each do |object|
      attr = OpenStruct.new
      attr.errors = []
      if opts[:check] && can_edit?
        attr.content = 'Not specified'
        attr.errors << 'blank' if (object.blank? || object[/not specified/])
      else
        p 'penis not found'
        attr.content =  object
      end
      o << attr
    end
    yield *o
  end

end
