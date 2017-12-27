class Photo < ApplicationRecord
  mount_uploader :file_path, PhotoUploader

  belongs_to :user

  validates :file_path, presence: true
end
