class FriendingsController < ApplicationController
  before_action :require_login

  def create
    friend_recipient = User.find(params[:id])
    if current_user.friended_users << friend_recipient
      redirect_to timeline_path(friend_recipient),
                  notice: "Added #{friend_recipient.first_name} as friend."
    end
  end
end