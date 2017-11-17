class SessionsController < ApplicationController
  def create
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_to users_url, notice: 'You successfully signed in'
    else
      flash[:notice] = 'Failed login'
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: 'You have signed out'
  end
end