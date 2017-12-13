require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'scope: #liked_by_user' do
    it 'returns likes from specific user' do
      user = create :user
      other_user = create :user
      likable_type = create :post

      likable_type.likes.create user: other_user
      expected_post = likable_type.likes.create user: user

      expect(likable_type.likes.liked_by_user(user))
        .to contain_exactly expected_post
    end
  end
end
