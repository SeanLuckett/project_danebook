class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true, counter_cache: :likable_count

  scope :liked_by_user, ->(user) { where(user_id: user.id) }
end
