require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without an email' do
    user = build :user, email: nil
    user.valid?
    expect(user.errors[:email]).to include "can't be blank"
  end

  describe 'email' do
    it 'is invalid without an email' do
      user = build :user, password: nil, password_confirmation: nil
      user.valid?
      expect(user.errors[:password]).to include "can't be blank"
    end

    it 'email must have an @ symbol in it' do
      user = build :user, email: 'right_length'
      user.valid?
      expect(user.errors[:email]).to include 'must have an @ symbol'
    end

    it 'email must be unique' do
      u = create :user
      new_user = build :user, email: u.email
      new_user.valid?
      expect(new_user.errors[:email]).to include 'has already been taken'
    end
  end


  describe 'password' do
    it 'must be a minimum 8 characters' do
      user = build :user, password: 'short'
      user.valid?
      expect(user.errors[:password]).to include 'is too short (minimum is 8 characters)'
    end

    it 'is no more than 24 characters' do
      user = build :user, password: 'long' * 7
      user.valid?
      expect(user.errors[:password]).to include 'is too long (maximum is 24 characters)'
    end
  end
end
