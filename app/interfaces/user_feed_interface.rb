class UserFeedInterface < ModelInterface

  def build_feed(type = :community)
    feed_class = "#{type.capitalize}Feed".constantize
    @feed = feed_class.new(self)
  end

  def feed
    @feed
  end

end