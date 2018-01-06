FactoryBot.define do
  factory :user do
    after(:build) do |user|
      user.account ||= create :account, user: user
    end
  end
end
