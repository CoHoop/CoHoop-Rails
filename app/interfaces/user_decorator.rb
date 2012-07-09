# Public: Decorates an instance of User, providing additional methods and new
# behaviors.
#
# Examples
#
#   user = UserDecorator.decorate(User.find(1))
#   user.user_name # => Firstname Lastname
class UserDecorator < ApplicationDecorator
  decorates :user

  # Public: Constructs the complete user name.
  #
  # Returns the user name as a String.
  def user_name
    self.first_name + ' ' + self.last_name
  end

  # TODO: Should be refactored in a may_not_be_specified method which will
  # define the methods according to the attributes past

  # Public: Pass the argument to may_not_be_specified.
  #
  # Returns an Hash containing
  # :content for the attribute value and
  # :class for the css error class attribute
  def university; may_not_be_specified :university end

  # Public: Pass the argument to may_not_be_specified.
  #
  # Returns an Hash containing
  # :content for the attribute value and
  # :class for the css error class attribute
  def biography;  may_not_be_specified :biography  end

  # Public: Pass the argument to may_not_be_specified.
  #
  # Returns an Hash containing
  # :content for the attribute value and
  # :class for the css error class attribute
  def job       ; may_not_be_specified :job        end
end