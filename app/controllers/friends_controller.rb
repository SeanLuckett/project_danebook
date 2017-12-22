class FriendsController < ApplicationController
  def index
    user = User.find(params[:user_id])

    render :index, locals: {
      user: UserDecorator.new(user),
      friends: decorated_friends(user.friended_users)
    }
  end

  def decorated_friends(friends)
    friends.map { |f| UserDecorator.new(f) }
  end
end