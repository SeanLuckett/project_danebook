class Profile < ApplicationRecord
  belongs_to :user
  has_one :address

  enum sexual_id: { who_cares: 0, female: 1, male: 2, neither: 3, both: 4 }

  def name
    "#{first_name} #{last_name}"
  end
end
