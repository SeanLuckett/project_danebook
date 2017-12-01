class TimelinesController < ApplicationController
  def show
    user = UserDecorator.new(User.find(params[:user_id]))
    render :show, locals: { user: user }
  end
end