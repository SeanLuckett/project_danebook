class Photo < ApplicationRecord
  mount_uploader :file_path, PhotoUploader

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  validates :file_path, presence: true
end
