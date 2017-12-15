require 'rails_helper'

RSpec.describe 'Post requests', type: :request do
  describe 'Post /comments' do
    let(:user) { create :user }

    context 'with logged in user' do
      before do
        sign_in(user.account)
      end

      it 'creates a post' do
        expect {
          post posts_path, params: { post: attributes_for(:post, user: user) }
        }.to change(Post, :count).by(1)

        expect(response).to redirect_to timeline_path(user)
      end

      context 'bad data' do
        it 'redirects to timeline with error message' do
          post posts_path,
               params: { post: attributes_for(:post, user: user, body: nil) }

          expect(flash[:notice]).to eq 'Could not post your post.'
          expect(response).to redirect_to timeline_path(user)
        end
      end
    end

    context 'with unlogged in visitor' do
      it "redirects to login path" do
        post posts_path, params: { post: attributes_for(:post, user: user) }
        expect(response).to redirect_to login_path
      end
    end
  end
end