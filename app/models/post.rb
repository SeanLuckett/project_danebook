class Post < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  scope :most_recent_first, -> { order(created_at: :desc) }
end
