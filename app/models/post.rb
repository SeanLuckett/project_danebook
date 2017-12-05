class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy

  validates :body, presence: true

  scope :most_recent_first, -> { order(created_at: :desc) }

  def is_liked?
    likes.any?
  end

  def liked_by_user?(user)
    likes.liked_by_user(user).any?
  end
end
