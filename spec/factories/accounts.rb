FactoryBot.define do
  factory :account do
    sequence :email do |n|
      "#{n}#{Faker::Internet.safe_email}"
    end
    password "Somepaswd2"
    password_confirmation "Somepaswd2"

    after(:build) do |account|
      account.user ||= build :user, account: account
    end
  end
end
