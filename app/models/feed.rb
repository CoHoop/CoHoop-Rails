class Feed
  delegate :avatar, :name, to: :user
  attr_reader :filters, :filter, :user

  def initialize(user, page)
    @user = user
    @page = page

    @filters = [:all, :urgent, :microhoops, :activities]
    @filter  = :all
  end

  def filter=(symbol)
    # TODO: Cumulable filters
    symbol = symbol.to_sym
    raise ArgumentError, "#{symbol} filter does not exists" unless @filters.include? symbol
    @filter = symbol
  end

  ## Must be overloaded by subclasses ##
  def type
    raise NotImplementedError, "#type method is not implemented for #{self.class}"
  end

  def microhoops
    raise NotImplementedError, "#microhoops method is not implemented for #{self.class}"
  end

  def microhoops_with_priority(opts = { urgent: false })
    urgent = opts[:urgent]
    self.microhoops.where('urgent = ?', urgent)
  end

  def activities
    raise NotImplementedError, "#activities method is not implemented for #{self.class}"
    # TODO: Implement Activities
  end
end
