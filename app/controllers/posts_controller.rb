class PostsController < ApplicationController

  def create
    user = User.find params[:user][:id]
    user.posts.build post_params

    respond_to do |format|
      msg = user.save ? 'Post posted, or posted post, if you will!' :'Could not post your post.'
      format.html { redirect_to timeline_path(user), notice: msg }
    end
  end

  def destroy
    post = Post.find(params[:id])
    user = post.user

    msg = post.destroy ? 'Post deleted' : 'Failed to delete post'
    redirect_to timeline_path(user), notice: msg
  end

  private

  def post_params
    params.require(:post).permit :body
  end

  def user_params
    params.require(:user).permit :id
  end
end