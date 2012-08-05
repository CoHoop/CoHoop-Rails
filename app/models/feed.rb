class Feed
  delegate :avatar, to: :user

  def initialize(user)
    @user = user
  end

  # Must be overloaded by subclasses
  def type
    raise NotImplementedError, "#type method is not implemented for #{self.class}"
  end

  def user
    @user
  end

  def microhoops(opts)
    raise NotImplementedError, "#microhoops method is not implemented for #{self.class}"
    # TODO: Take the followers into account
  end

  def activities
    raise NotImplementedError, "#activities method is not implemented for #{self.class}"
    # TODO: Implement Activities
  end

  def content(filter = :none)
    case filter
      when :none
        # TODO: Should merge both by date, activities and microhoops should have the same interface
        [microhoops, activities]
      when :urgent
        microhoops(urgent: true)
      when :microhoops
        microhoops
      when :activities
        activities
      else
        raise ArgumentError, "#{filter} filter does not exists"
    end
  end
end
