class LikesController < ApplicationController
  def create
    liked_resource = LikedResource.new(params)
    record = liked_resource.record

    timeline_user = liked_resource.user

    record.likes.build user_id: current_user.id
    msg = if record.save
            successfully_created_msg(liked_resource.type, timeline_user)
          else
            'Unable to process this like!'
          end

    redirect_to timeline_path(timeline_user), notice: msg
  end

  def destroy
    liked_resource = LikedResource.new(params)

    timeline_user = liked_resource.user

    current_user_like = liked_resource.record.likes.liked_by_user(current_user)

    msg = current_user_like.destroy_all ? "You unliked #{liked_resource.type.downcase} by #{timeline_user.first_name}." : 'Could not unlike!'
    redirect_to timeline_path(timeline_user), notice: msg
  end

  private
  def successfully_created_msg(likable_type, timeline_user)
    "You liked #{likable_type.downcase} by #{timeline_user.first_name}!"
  end
end