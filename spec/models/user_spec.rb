require 'rails_helper'

RSpec.describe 'User', type: :model do
  describe 'validations' do
    it 'is invalid without a first name' do
      user = build :user, first_name: nil
      user.valid?
      expect(user.errors[:first_name]).to include "can't be blank"
    end
  end

  describe 'friending' do
    context 'user is initiator' do
      it 'gets a friended user' do
        user_friending = create :user
        user_friended = create :user

        user_friending.friended_users<< user_friended
        expect(user_friending.friended_users).to contain_exactly user_friended
      end
    end
  end
end