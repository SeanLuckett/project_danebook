FactoryBot.define do
  factory :comment do
    user
    post
    body "MyText"
  end
end
