class LikesController < ApplicationController
  def create
    likable_type = params[:likable]
    likable_resource_id = "#{likable_type.downcase}_id".to_sym

    liked_resource = likable_type.constantize.find(params[likable_resource_id])
    liked_resource.likes.build user_id: current_user.id

    timeline_user = case likable_type
                      when 'Comment'
                        liked_resource.post.user
                      when 'Post'
                        liked_resource.user
                    end

    msg = if liked_resource.save
            successfully_created_msg(likable_type, timeline_user)
          else
            'Unable to process this like!'
          end

    redirect_to timeline_path(timeline_user), notice: msg
  end

  def destroy
    likable_type = params[:likable]
    likable_resource_id = "#{likable_type.downcase}_id".to_sym

    liked_resource = likable_type.constantize.find(params[likable_resource_id])

    timeline_user = case likable_type
                      when 'Comment'
                        liked_resource.post.user
                      when 'Post'
                        liked_resource.user
                    end

    current_user_like = liked_resource.likes.liked_by_user(current_user)

    msg = current_user_like.destroy_all ? "You unliked #{likable_type.downcase} by #{timeline_user.first_name}." : 'Could not unlike!'
    redirect_to timeline_path(timeline_user), notice: msg
  end

  private
  def successfully_created_msg(likable_type, timeline_user)
    "You liked #{likable_type.downcase} by #{timeline_user.first_name}!"
  end
end