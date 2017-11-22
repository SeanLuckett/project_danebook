class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true,
                    format: { with: /@/, message: 'must have an @ symbol' }

  validates :password, length: { in: 8..24 }
end
