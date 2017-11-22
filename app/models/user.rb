class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true,
                    format: { with: /@/, message: 'must have an @ symbol' }

  validates :password, length: { in: 8..24 }

  enum sexual_ident: { who_cares: 0, female: 1, male: 2, neither: 3, both: 4 }
end
