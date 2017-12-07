class PostsController < ApplicationController

  def create
    current_user.posts.build post_params

    respond_to do |format|
      msg = current_user.save ? 'Post posted, or posted post, if you will!' :'Could not post your post.'
      format.html { redirect_to timeline_path(current_user), notice: msg }
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])

    msg = post.destroy ? 'Post deleted' : 'Failed to delete post'
    redirect_to timeline_path(current_user), notice: msg
  end

  private

  def post_params
    params.require(:post).permit :body
  end
end