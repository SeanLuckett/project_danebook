class CommentsController < ApplicationController
  before_action :require_login

  def create
    post = Post.find params[:post_id]
    post.comments.build comment_params.merge(user_id: current_user.id)

    respond_to do |format|
      msg = post.save ? 'Comment commented, or commented comment, if you will!' : 'Could not save your comment.'
      format.html {
        redirect_to timeline_path(post.user), notice: msg
      }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    poster = comment.post.user

    msg = comment.destroy ? 'Comment deleted' : 'Failed to delete comment'
    redirect_to timeline_path(poster), notice: msg
  end

  private

  def comment_params
    params.require(:comment).permit :body
  end
end