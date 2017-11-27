class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in_user?
    current_user.present?
  end
  helper_method :logged_in_user?

  def require_login
    unless logged_in_user?
      redirect_to login_path, notice: 'You must be signed in to do that'
    end
  end

  def sign_in(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def sign_out
    @current_user = nil
    session.delete :user_id
  end
end
