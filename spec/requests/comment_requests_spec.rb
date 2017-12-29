require 'rails_helper'

RSpec.describe 'Comment Requests', type: :request do
  let(:user) { create :user }

  describe 'POST #create' do
    let(:commentable) { create :post }

    context 'with logged in user' do
      before do
        sign_in(user.account)
      end

      it 'creates a comment' do
        expect {
          post post_comments_path(commentable),
               params: { comment: attributes_for(:comment_for_post) }
        }.to change(Comment, :count).by(1)

        expect(response).to redirect_to timeline_path(commentable.user)
      end


      context 'bad data' do
        it "redirects to post's user's timeline with error message" do
          post post_comments_path(commentable),
               params: { comment: attributes_for(:comment_for_post, body: nil) }

          expect(flash[:notice]).to eq 'Could not save your comment.'
          expect(response).to redirect_to timeline_path(commentable.user)
        end
      end
    end

    context 'with unlogged in visitor' do
      it "redirects to login path" do
        post post_comments_path(commentable),
             params: { comment: attributes_for(:comment_for_post) }

        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in user.account }

    it 'deletes the comment' do
      comment = create :comment_for_post
      expect {
        delete comment_path(comment)
      }.to change(Comment, :count).by(-1)
    end
  end
end