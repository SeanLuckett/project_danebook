module ApplicationHelper
  def active_nav_item_if(path)
    'active' if current_page?(path)
  end

  def decorated_comments(post)
    post.latest_comments.map { |p| LikableDecorator.new(p) }
  end

  def linkable_photo?(user)
    user.id == current_user.id || current_user.friended_users.exists?(user.id)
  end
end
