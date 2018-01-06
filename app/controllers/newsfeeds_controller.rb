class NewsfeedsController < ApplicationController
  before_action :require_login

  def show
    if current_user.id == params[:user_id].to_i
      friend_ids = current_user.friended_user_ids
      friend_posts = Post.where(user_id: friend_ids)

      all_posts = friend_posts.or(current_user.posts)

      render :show, locals: {
        posts: all_posts.most_recent_first,
        active_friend_posts: friend_posts.most_recent_first.within_days(3)
      }
    else
      redirect_to newsfeed_path current_user
    end
  end
end