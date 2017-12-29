class TimelinesController < ApplicationController
  before_action :require_login

  def show
    user = UserDecorator.new(user_with_displayables)
    photos = user.photos.sample(9)
    render :show, locals: {
      user: user,
      posts: decorated_posts(user),
      displayable_photos: photos
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