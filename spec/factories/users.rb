require 'faker/internet'

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "#{n}#{Faker::Internet.safe_email}"
    end
    password "Somepaswd2"
    password_confirmation "Somepaswd2"
  end
end
