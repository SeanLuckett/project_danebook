require 'rails_helper'

RSpec.describe 'User requests', type: :request do
  describe 'PATCH #update' do
    let(:user) { create :user, hometown: nil }
    let(:hometown) { 'Springfield, IL' }

    context 'logged in user' do
      before { sign_in user.account }

      it 'updates user and redirects' do
        patch user_path(user), params: { user: { hometown: hometown } }

        expect(response).to redirect_to user_path(user)
        expect(user.reload.hometown).to eq hometown
      end
    end

    context 'not logged in visitor' do
      it 'updates user and redirects' do
        patch user_path(user), params: { user: { hometown: hometown } }
        expect(response).to redirect_to login_path
      end
    end
  end
end