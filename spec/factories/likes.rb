FactoryBot.define do
  factory :like do
    association :likable, factory: :post
    user
  end
end
