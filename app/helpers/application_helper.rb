module ApplicationHelper
  def active_nav_item_if(path)
    'active' if current_page?(path)
  end

  def decorated_comments(post)
    post.latest_comments.map { |p| LikableDecorator.new(p) }
  end

  def display_cover_image(user)
    if user.cover_img.present?
      image_tag user.cover_img, width: '100%', height: '350', class: 'img-responsive'
    end
  end

  def display_profile_photo(user, size: '125', classes: 'float-left mr-sm-2')
    if user.avatar.present?
      image_tag user.avatar, size: size, class: classes
    end
  end

  def likable_actions(resource)
    if resource.liked_by_user? current_user
      link_to('Unlike', url_for([resource, :like]),
              method: :delete, class: 'mr-sm-2')
    else
      link_to('Like', url_for([resource, :likes]),
              method: :post, class: 'mr-sm-2')
    end
  end

  def linkable_photo?(user)
    user.id == current_user.id || current_user.friended_users.exists?(user.id)
  end
end
