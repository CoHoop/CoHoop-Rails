# Public: Provide convenience methods to use a Presenter in rails views.
module PresenterHelper
  # Public: Instanciates a Presenter. It will be passed to a block.
  #
  # object - A model instance to be wrapped inside the Presenter.
  # args   - The Hash containing the path of the presenter to use.
  #          Arguments can be:
  #            :presenter    - A single presenter as a Symbol.
  #              :presenters - Some presenters path as Symbols in an Array.
  #                            [:user, :profile] will access UserProfilePresenter
  #
  # Yields a Presenter instance.
  #
  # Examples
  #
  #  present(@user, presenters: [:user, :profile ])
  #  #=> <UserProfilePresenter>
  #
  #  present(@user, presenter: :user)
  #  #=> <UserPresenter>
  #
  #  present(@user, presenter: :user) { |presenter| presenter.method_name }
  #  #=> <UserPresenter>
  #
  # Returns an ApplicationPresenter subclass instance.
  def present(object, options = {})
    presenters_path = *options[:presenter] || options[:presenters]

    klass = get_presenter_class(object, presenters_path)
    presenter = klass.new(object, self)

    yield presenter if block_given?
    presenter
  end

  private
    # Private: Get the presenter class constant
    #
    # object           - Object to present.
    # presenters_chain - Array of Symbols representing the presenter name.
    #
    # Examples
    #
    #  get_presenter_class(User.new, [:user, :profile])
    #  # => UserProfilePresenter
    #
    #  get_presenter_class(User.new)
    #  # => UserPresenter
    #
    # Returns an ApplicationPresenter subclass constant.
    def get_presenter_class(object, presenters_path)
      klass = if presenters_path
        "#{presenters_path.map(&:capitalize).join}Presenter"
      else
        "#{object.class}Presenter"
      end
      klass.constantize
    end
end
