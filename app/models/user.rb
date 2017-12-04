class User < ApplicationRecord
  belongs_to :account
  has_many :posts

  enum sexual_id: { who_cares: 0, female: 1, male: 2, neither: 3, both: 4 }

  def latest_posts
    posts.most_recent_first
  end
end
