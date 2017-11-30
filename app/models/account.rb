class Account < ApplicationRecord
  has_secure_password
  has_one :user, dependent: :destroy

  validates :email,
            presence: true,
            format: { with: /@/, message: 'must have an @ symbol' },
            uniqueness: true

  validates :password, length: { in: 8..24 }

  validates :user, presence: { message: "can't be created without a user" }
end
