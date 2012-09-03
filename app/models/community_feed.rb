class CommunityFeed < Feed
  def type
    :community
  end

  def microhoops
    Microhoop
      .where('user_id in (select r.followed_id as uid from relationships as r where follower_id = ?) or user_id = ?', user.id, user.id)
      .order('created_at DESC')
      .paginate(page: @page)
  end
end
