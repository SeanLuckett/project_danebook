class Photo < ApplicationRecord
  mount_uploader :file_path, PhotoUploader

  belongs_to :user

end
