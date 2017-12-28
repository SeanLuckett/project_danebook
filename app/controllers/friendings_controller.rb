class FriendingsController < ApplicationController
  before_action :require_login

  def create
    friend_recipient = User.find(params[:id])
    if current_user.friended_users << friend_recipient
      redirect_back(fallback_location: timeline_path(current_user),
        notice: "Added #{friend_recipient.first_name} as friend.")
    end
  end

  def destroy
    unfriended = User.find(params[:id])

    if current_user.friended_users.exists? unfriended.id
      current_user.friended_users.destroy unfriended
      redirect_back(fallback_location: timeline_path(current_user),
                    notice: "You and #{unfriended.first_name} are no longer friends.")
    else
      redirect_to timeline_path(params[:id])
    end
  end
end