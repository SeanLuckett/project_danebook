class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    post.likes.build user_id: current_user.id

    msg = post.save ? "You liked post by #{post.user.first_name}!" : 'Unable to process this like!'
    redirect_to timeline_path(post.user), notice: msg
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user_like = post.likes.liked_by_user(current_user)

    msg = current_user_like.destroy_all ? "You unliked post by #{post.user.first_name}." : 'Could not unlike!'
    redirect_to timeline_path(post.user), notice: msg
  end
end