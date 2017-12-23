class User < ApplicationRecord
  belongs_to :account
  has_many :posts
  has_many :photos

  # Friends
  # Initiating friending
  has_many :initiated_friendings, foreign_key: :friender_id, class_name: 'Friending'
  has_many :friended_users, through: :initiated_friendings, source: :friend_recipient

  # Receiving friending
  has_many :received_friendings, foreign_key: :friend_id, class_name: 'Friending'
  has_many :users_friended_by, through: :received_friendings, source: :friend_initiator

  enum sexual_id: { who_cares: 0, female: 1, male: 2, neither: 3, both: 4 }

  def latest_posts
    posts.most_recent_first
  end
end
