class AccountsController < ApplicationController
  def new
    account = Account.new
    render :new, locals: { account: account, user: account.build_user }
  end

  def create
    account = Account.new(account_params)
    account.build_user(user_params)

    respond_to do |format|
      if account.save
        sign_in account.user

        format.html do
          redirect_to user_path(account.user),
                      notice: 'User was successfully created.'
        end
      else
        format.html do
          render :new, locals: { account: account, user: account.user }
        end
      end
    end
  end

  private

  def account_params
    params.require(:account).permit :email, :password, :password_confirmation
  end

  def user_params
    params
      .require(:account)
      .require(:user_attributes)
      .permit :first_name, :last_name, :birthdate, :sexual_id
  end
end