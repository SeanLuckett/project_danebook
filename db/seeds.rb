# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker/educator'
require 'faker/address'
require 'faker/phone_number'

5.times do |i|
  u = User.create email: "pat#{i}.just@nyc.com",
                  password: "foo#{i}barr",
                  password_confirmation: "foo#{i}barr"

  p = u.create_profile first_name: "Pat#{i}",
                       last_name: "Foo",
                       birthdate: 20.years.ago,
                       college: Faker::Educator.university,
                       hometown: Faker::Address.city,
                       telephone: Faker::PhoneNumber.phone_number

  p.create_address street1: Faker::Address.street_address,
                   city: Faker::Address.city,
                   state: Faker::Address.state_abbr,
                   postcode: Faker::Address.postcode
end