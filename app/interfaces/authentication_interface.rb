#require 'interfaces/interface'

class AuthenticationInterface < ModelInterface
  delegate :can?, :cannot?, :to => :ability

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

  def ability
    @ability ||= Ability.new(@current_user)
  end
end