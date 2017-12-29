class TimelinesController < ApplicationController
  before_action :require_login

  def show
    user = UserDecorator.new(user_with_displayables)

    render :show, locals: {
      user: user,
      posts: decorated_posts(user),
      displayable_photos: user.photos.sample(9),
      displayable_friends: user.friended_users.sample(6)
    }
  end

  private

  def decorated_posts(user)
    user.latest_posts.map { |p| LikableDecorator.new(p) }
  end

  def user_with_displayables
    User
      .where(id: params[:user_id])
      .includes(:posts)
      .includes(:friended_users)
      .includes(:photos)
      .first
  end

end