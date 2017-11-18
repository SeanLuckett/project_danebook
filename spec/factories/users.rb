require 'faker/internet'

FactoryBot.define do
  factory :user do
    email Faker::Internet.safe_email
    password "Somepaswd2"
    password_confirmation "Somepaswd2"
  end
end
