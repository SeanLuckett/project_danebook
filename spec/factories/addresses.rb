FactoryBot.define do
  factory :address do
    profile
    street1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    postcode { Faker::Address.postcode }
  end
end
