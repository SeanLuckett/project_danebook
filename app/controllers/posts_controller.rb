class PostsController < ApplicationController
  def destroy
    post = Post.find(params[:id])
    user = post.user

    if post.destroy
      redirect_to timeline_path(user), notice: 'Post deleted'
    else
      redirect_to timeline_path(user), notice: 'Failed to delete post'
    end
  end
end