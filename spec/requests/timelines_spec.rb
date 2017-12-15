require 'rails_helper'

RSpec.describe 'Timelines', type: :request do
  describe 'GET /timeline' do
    let(:user) { user = create :user }

    context 'with logged in user' do
      it 'succeeds' do
        post session_path, params: { email: user.account.email, password: user.account.password }

        get timeline_path(user)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with logged out visitor' do
      it 'redirects to login' do
        get timeline_path(user)
        expect(response).to redirect_to login_path
      end
    end
  end
end
