class AuthenticationInterface < ModelInterface
  delegate :can?, :cannot?, :to => :ability

  # Public: A new instance of AuthenticationInterface.
  #
  # component    - The model to decorate.
  # current_user - As authentication interface will deal with user
  #                authentication, the current user must be passed.
  def initialize(component, current_user)
    super component
    @current_user = current_user
  end

  # Public: Checks if the current user has edition rights
  #
  # Returns a Boolean.
  def can_edit?
    can? :update, @component
  end

  # Not documented.
  def ability
    @ability ||= Ability.new(@current_user)
  end
end