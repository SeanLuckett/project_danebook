class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  validates :body, presence: true

  scope :most_recent_first, -> { order(created_at: :desc) }

  def is_liked?
    likable_count > 0
  end

  def latest_comments
    comments.most_recent_first
  end

  def liked_by_user?(user)
    likes.liked_by_user(user).any?
  end

  def likes_not_by(user)
    likes.where.not(user_id: user.id)
  end
end
