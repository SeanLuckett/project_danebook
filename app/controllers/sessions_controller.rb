class SessionsController < ApplicationController
  def create
    account = Account.find_by email: params[:email]
    if account && account.authenticate(params[:password])
      sign_in account.user
      redirect_to user_url(account.user), notice: 'You successfully signed in'
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