require 'rails_helper'

RSpec.describe 'Like requests', type: :request do
  describe 'POST #create' do
    context 'Likable is Post' do
      let(:user_post) { create :post }
      let(:user) { user_post.user }

      it 'requires logged in user' do
        post post_likes_path(user_post)
        expect(response).to redirect_to login_path
      end

      context 'with logged in user' do
        before do
          sign_in user.account

          expect(user_post.likable_count).to eq 0
          post post_likes_path(user_post)
        end

        specify { expect(response).to redirect_to timeline_path(user) }

        it 'creates a :like for the post' do
          expect(user_post.reload.likable_count).to eq 1
        end
      end
    end

    context 'Likable is Comment' do
      let(:user_comment) { create :comment }
      let(:user) { user_comment.post.user }

      context 'with logged in user' do
        before do
          sign_in user.account

          expect(user_comment.likable_count).to eq 0
          post comment_likes_path(user_comment)
        end

        specify { expect(response).to redirect_to timeline_path(user_comment.post.user) }

        it 'creates a :like for the post' do
          expect(user_comment.reload.likable_count).to eq 1
        end
      end
    end

  end
end