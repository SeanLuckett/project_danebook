require 'rails_helper'

RSpec.describe 'Friending requests', type: :request do
  describe 'POST #create' do
    it 'creates a friending between two users' do
      friender = create :user
      friended = create :user

      sign_in friender.account
      post friendings_path, params: { id: friended.id }
      expect(friender.reload.friended_users).to contain_exactly friended
      expect(friended.reload.users_friended_by).to contain_exactly friender
    end
  end
end