require 'modules/user_presenter'

class UserFeedPresenter < ApplicationPresenter
  include UserPresenter

  def feed_type
    if feed.type == :tag
      link_to "Community feed", _.feed_path(feed_type: :community)
    else
      link_to "Tags feed", _.feed_path(feed_type: :tags)
    end
  end

  def filters
    feed_type = _.params[:feed_type] || feed.type
    wrap_in(:ul, id: 'filters-list') do
      feed.filters.collect do |filter|
        render partial: 'feeds/filter', locals: { filter: filter, feed_type: feed_type }
      end.join.html_safe
    end
  end

  def add_microhoop_form
    render partial: 'users/microhoops/add_microhoop_form', locals: { user: current_user }
  end

  def feed_title
    feed.type.capitalize.to_s + ' feed'
  end

  def feed_content
    case feed.filter
      # TODO: Need to change all target method
      # TODO: Let the feed model handle filtering
      when :all         then all_microhoops
      when :microhoops  then all_microhoops
      when :urgent      then urgent_microhoops
      when :similar_content   then all_microhoops
      when :similar_users     then all_microhoops
      when :activities  then raise NotImplementedError
    end
  end

  # Public: displays all community's urgent microhoops
  #
  # Returns an HTML String.
  def urgent_microhoops
    render_microhoops(true)
  end

  # Public: displays all community's microhoops
  #
  # Returns an HTML String.
  def all_microhoops
    render_microhoops(false)
  end

  # Public: display all users'
  def list_all_users
    # TODO: Should make UserPresenter a class not a module, so we don't need to user UsersProfilePresenter
    # TODO: Should extract User.all in the model
    users = User.all
    users.delete(current_user) if current_user
    users = UserInterface.new(users)
    # TODO: Should use a factory for Presenter and interfaces
    all_users = users.map { |u| UserProfilePresenter.new(UserInterface.new(AuthenticationInterface.new(u, current_user)), helper, 'User') }
    render partial: 'users/shared/list', locals: { users: all_users, avatar_size: :small }
  end

  def render_each_microhoop_for(query)
    query.collect do |microhoop|
      microhoop.content.convert_tags_to_html_links('#') { |name|
        tag = Tag.find_by_name(name.downcase)
        id  = tag.nil? ? '' : tag.id
        "/tags/#{id}"
      }
      microhoop.content = microhoop.content.html_safe
      user = UserFeedPresenter.new(UserInterface.new(microhoop.user), helper)
      render(partial: 'feeds/microhoop', locals: { user: user, microhoop: microhoop })
    end.join
  end

  private
  def feed
    model
  end

  def render_microhoops(with_priority)
    css_class  = %(microhoops) << (with_priority ? ' urgent' : '')
    microhoops = with_priority ? feed.microhoops_with_priority(urgent: true) : feed.microhoops

    wrap_in(:ul, class: css_class) do
      # We need to use SafeBuffer because the join converts all partials
      # into a string instead of an OutputBuffer
      render_each_microhoop_for(microhoops).html_safe
    end +
    _.will_paginate(microhoops)
  end
end
