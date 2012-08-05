class CommunityFeed < Feed
  def type
    :community
  end

  def microhoops(opts = { urgent: false })
    urgent = opts[:urgent]
    Microhoop.where(urgent: urgent).order('created_at DESC').
      all(conditions: ['user_id in (select r.followed_id as uid from relationships as r where follower_id = ?) or user_id = ?', user.id, user.id])
  end
end
