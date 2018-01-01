class Photo < ApplicationRecord
  mount_uploader :file_path, PhotoUploader

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  validates :file_path, presence: true

  def is_liked?
    likable_count > 0
  end

  def liked_by_user?(user)
    likes.liked_by_user(user).any?
  end

  def likes_not_by(user)
    likes.where.not(user_id: user.id)
  end
end
