class PhotosController < ApplicationController
  before_action :require_login

  def index
    user = User.find params[:user_id]
    render :index, locals: { user: UserDecorator.new(user), photos: user.photos }
  end

  def new
    render :new, locals: { user: UserDecorator.new(current_user) }
  end

  def create
    upload = current_user.photos.build photo_params

    respond_to do |format|
      if upload.save
        format.html { redirect_to photos_path(current_user), notice: 'Uploaded photo!' }
      else
        format.html { render :new, locals: { user: UserDecorator.new(current_user) }, notice: 'Failed to upload photo.' }
      end
    end
  end

  private

  def photo_params
    params.require(:photo).permit :file_path
  end
end