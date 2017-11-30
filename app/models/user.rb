class User < ApplicationRecord
  belongs_to :account
  has_one :profile
  accepts_nested_attributes_for :profile, allow_destroy: true

  enum sexual_id: { who_cares: 0, female: 1, male: 2, neither: 3, both: 4 }
end
