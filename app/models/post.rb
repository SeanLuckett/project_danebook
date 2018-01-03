class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  validates :body, presence: true

  scope :most_recent_first, -> { order(created_at: :desc) }

  def latest_comments
    comments.most_recent_first
  end

end
