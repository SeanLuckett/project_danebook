class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true

  scope :most_recent_first, -> { order(created_at: :desc) }
end
