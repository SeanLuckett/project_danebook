class User < ApplicationRecord
  has_secure_password
  has_one :profile
  accepts_nested_attributes_for :profile, allow_destroy: true

  validates :email,
            presence: true,
            format: { with: /@/, message: 'must have an @ symbol' },
            uniqueness: true

  validates :password, length: { in: 8..24 }

end
