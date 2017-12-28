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

  describe 'POST #delete' do
    it 'deletes a friending between two users' do
      friender = create :user
      friended = create :user
      friender.friended_users << friended

      sign_in friender.account

      delete friending_path(friended)
      expect(friender.reload.friended_users).to be_empty
      expect(friended.reload.users_friended_by).to be_empty
    end

    context "when someone else's friending" do
      let(:user) { create :user }
      before { sign_in user.account }

      it 'does not remove the friending' do
        another_user = create :user
        another_user_friend = create :user
        another_user.friended_users << another_user_friend

        delete friending_path(another_user_friend)
        expect(another_user.reload.friended_users.count).to be 1
      end
    end
  end
end