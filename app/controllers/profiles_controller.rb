class ProfilesController < ApplicationController
  layout 'profile', only: [:show, :edit]

  before_action :require_login, only: [:edit, :update]

  def show
    profile = Profile.find(params[:id])
    render :show, locals: { user: profile.user, profile: profile }
  end

  def edit
    profile = Profile.find(params[:id])
    render :edit, locals: { user: profile.user, profile: profile }
  end

  def update
    profile = Profile.find params[:id]

    if profile.update profile_params
      redirect_to user_profile_path(profile.user, profile)
    else
      render :edit, locals: { user: profile.user, profile: profile }
    end
  end

  private

  def profile_params
    params
      .require(:profile)
      .permit(
        :first_name,
        :last_name,
        :birthdate,
        :college,
        :hometown,
        :lives_in,
        :telephone,
        :words_live_by,
        :about_me
      )
  end
end
