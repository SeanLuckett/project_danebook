class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likable, dependent: :destroy

  validates :body, presence: true

  scope :most_recent_first, -> { order(created_at: :desc) }
end
