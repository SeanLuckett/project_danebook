class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true,
                    length: { in: 8..24 },
                    format: { with: /@/, message: 'must have an @ symbol' }
end
