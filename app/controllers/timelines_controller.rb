class TimelinesController < ApplicationController
  before_action :require_login

  def show
    user = UserDecorator.new(User.find(params[:user_id]))
    render :show, locals: { user: user, posts: decorated_posts(user) }
  end

  private

  def decorated_posts(user)
    user.latest_posts.map { |p| PostDecorator.new(p) }
  end
end