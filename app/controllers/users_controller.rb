class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = UserDecorator.new(User.find(params[:id]))
  end

  def user_params
    params.require(:user).permit :college, :hometown, :lives_in, :telephone, :words_live_by, :about_me
  end
end
