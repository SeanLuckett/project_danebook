class Account < ApplicationRecord
  has_secure_password
  has_one :user

  validates :email,
            presence: true,
            format: { with: /@/, message: 'must have an @ symbol' },
            uniqueness: true

  validates :password, length: { in: 8..24 }

end
