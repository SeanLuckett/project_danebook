require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without an email' do
    user = build :user, email: nil
    user.valid?
    expect(user.errors[:email]).to include "can't be blank"
  end

  it 'is invalid without an email' do
    user = build :user, password: nil, password_confirmation: nil
    user.valid?
    expect(user.errors[:password]).to include "can't be blank"
  end

  describe 'email address' do
    it 'must be a minimum 8 characters' do
      user = build :user, email: 'short'
      user.valid?
      expect(user.errors[:email]).to include 'is too short (minimum is 8 characters)'
    end

    it 'is no more than 24 characters' do
      user = build :user, email: 'long' * 7
      user.valid?
      expect(user.errors[:email]).to include 'is too long (maximum is 24 characters)'
    end

    it 'must have an @ symbol in it' do
      user = build :user, email: 'right_length'
      user.valid?
      expect(user.errors[:email]).to include 'must have an @ symbol'
    end
  end
end
