class CommentsController < ApplicationController
  before_action :require_login

  def create
    commentable = params[:commentable].constantize.find params["#{params[:commentable].downcase}_id".to_sym]
    commentable.comments.build comment_params.merge(user_id: current_user.id)

    respond_to do |format|
      msg = commentable.save ? 'Comment commented, or commented comment, if you will!' : 'Could not save your comment.'
      format.html {
        redirect_back(fallback_location: timeline_path(commentable.user),
                      notice: msg)
      }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    commentable_owner = comment.commentable.user

    msg = comment.destroy ? 'Comment deleted' : 'Failed to delete comment'
    redirect_back(fallback_location: timeline_path(commentable_owner),
                  notice: msg)
  end

  private

  def comment_params
    params.require(:comment).permit :body
  end
end