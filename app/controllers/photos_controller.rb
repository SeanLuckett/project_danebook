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
        format.html {
          redirect_to photo_list_path(current_user),
                      notice: 'Uploaded photo!'
        }
      else
        format.html {
          render :new, locals: {
            user: UserDecorator.new(current_user)
          }, notice: 'Failed to upload photo.' }
      end
    end
  end

  def show
    photo = Photo.find(params[:id])

    if friendship_exists?(photo.user.id) || belongs_to_current_user?(photo)
      render :show, locals: {
        photo: PhotoDecorator.new(photo),
        user: UserDecorator.new(photo.user),
        comments: photo.comments.map { |c| LikableDecorator.new(c) }
      }
    else
      redirect_to photo_list_path photo.user
    end
  end

  def destroy
    photo = Photo.find params[:id]
    if photo.destroy
      redirect_to photo_list_path(photo.user), notice: 'Deleted photo'
    end
  end

  def set_profile
    photo = Photo.find(params[:photo_id])
    if current_user.update(avatar: photo.file_path.thumb.url)
      redirect_to photo_path(photo), notice: 'Set profile photo.'
    end
  end

  def set_cover
    photo = Photo.find(params[:photo_id])
    if current_user.update(cover_img: photo.file_path.url)
      redirect_to photo_path(photo), notice: 'Set cover photo.'
    end
  end

  private
  def belongs_to_current_user?(photo)
    photo.user.id == current_user.id
  end

  def friendship_exists?(user)
    current_user.friended_users.exists?(user)
  end

  def photo_params
    params.require(:photo).permit :file_path, :remote_file_path_url
  end
end