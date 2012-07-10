# Public: Decorates an instance of User, providing a query interface
# and additional behaviors
#
# Examples
#
#   user = UserInterface.new(User.find(1))
#   user.name # => Firstname Lastname
class UserInterface < ModelInterface
  # Public: Constructs the complete user name.
  #
  # Returns the user name as a String.
  def name
    self.first_name + ' ' + self.last_name
  end
end