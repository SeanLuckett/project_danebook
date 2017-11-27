class Address < ApplicationRecord
  belongs_to :profile

  validates :street1, :city, :state, :postcode, presence: true
end
