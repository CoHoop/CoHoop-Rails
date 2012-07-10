# Public: Decorates an instance of User, providing a query interface
# and additional behaviors
#
# Examples
#
#   user = UserProfileInterface.new(User.find(1))
class UserProfileInterface < UserInterface
  def university; may_not_be_set(__method__) end
  def job;        may_not_be_set(__method__) end
  def biography;  may_not_be_set(__method__) end
end