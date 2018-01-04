class NewsfeedsController < ApplicationController
  before_action :require_login

  def show
    if current_user.id == params[:user_id].to_i
      friend_ids = current_user.friended_user_ids << current_user.id
      friend_posts = Post.where(user_id: friend_ids).most_recent_first

      render :show, locals: { posts: friend_posts }
    else
      redirect_to newsfeed_path current_user
    end
  end
end