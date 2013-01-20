class TagFeed < Feed
  def initialize(user, page)
    super user, page

    @filters.unshift :similar_content, :similar_users
    @filter  =  :similar_content
  end
  def type
    :tag
  end

  def microhoops
    if self.filter == :similar_content
      Microhoop
        .where('id in (select r.microhoop_id from microhoops_tags_relationships as r where tag_id in (select r.tag_id from users_tags_relationships as r where user_id = ?))', user.id)
      .order('created_at DESC')
      .paginate(page: @page)
    else # from users
      Microhoop
      .where('user_id in (select r.user_id from users_tags_relationships as r where tag_id in (select r.tag_id from users_tags_relationships as r where user_id = ?))', user.id)
      .order('created_at DESC')
      .paginate(page: @page)
    end
  end
end
