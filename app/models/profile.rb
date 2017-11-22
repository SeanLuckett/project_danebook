class Profile < ApplicationRecord
  belongs_to :user

  enum sexual_id: { who_cares: 0, female: 1, male: 2, neither: 3, both: 4 }
end
