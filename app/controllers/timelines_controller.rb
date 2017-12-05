class TimelinesController < ApplicationController
  before_action :require_login

  def show
    user = UserDecorator.new(user_with_posts)
    render :show, locals: { user: user, posts: decorated_posts(user) }
  end

  private

  def decorated_posts(user)
    user.latest_posts.map { |p| LikableDecorator.new(p) }
  end

  def user_with_posts
    User.where(id: params[:user_id]).includes(:posts).first
  end

end