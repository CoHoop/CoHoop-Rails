class UserFeedInterface < UserInterface
  include ActiveSupport::Inflector

  def build_feed(page, type = :community)
    feed_class = "#{type.to_s.capitalize.singularize}Feed".constantize
    @feed = feed_class.new(self, page)
  end

  def feed
    @feed
  end

end
