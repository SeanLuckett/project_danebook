FactoryBot.define do
  factory :comment_for_post, class: :comment do
    user
    body "MyText"

    after(:build) do |comment|
      comment.commentable = create :post
    end
  end

  factory :comment_for_photo, class: :comment do
    user
    body "MyText"

    after(:build) do |comment|
      comment.commentable = create :photo
    end
  end
end
