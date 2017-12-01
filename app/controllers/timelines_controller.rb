class TimelinesController < ApplicationController
  before_action :require_login

  def show
    user = UserDecorator.new(User.find(params[:user_id]))
    render :show, locals: { user: user, posts: decorated_posts(user) }
  end

  private

  def decorated_posts(user)
    user.posts.map { |p| PostDecorator.new(p) }
  end
end
class PostDecorator < SimpleDelegator
  def formatted_date
    created_at.strftime '%A, %m %e %Y'
  end
end