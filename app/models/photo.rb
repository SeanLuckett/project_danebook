class Photo < ApplicationRecord
  mount_uploader :file_path, PhotoUploader

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :file_path, presence: true
end
