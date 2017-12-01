require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'is invalid without a user' do
    account = build :account
    account.user = nil

    account.valid?
    expect(account.errors[:user]).to include 'must exist to create account'
  end

  describe 'email' do
    it 'is invalid without an email' do
      account = build :account, password: nil, password_confirmation: nil
      account.valid?
      expect(account.errors[:password]).to include "can't be blank"
    end

    it 'email must have an @ symbol in it' do
      account = build :account, email: 'right_length'
      account.valid?
      expect(account.errors[:email]).to include 'must have an @ symbol'
    end

    it 'email must be unique' do
      a = create :account
      new_account = build :account, email: a.email
      new_account.valid?
      expect(new_account.errors[:email]).to include 'has already been taken'
    end
  end

  describe 'password' do
    it 'must be a minimum 8 characters' do
      account = build :account, password: 'short'
      account.valid?
      expect(account.errors[:password]).to include 'is too short (minimum is 8 characters)'
    end

    it 'is no more than 24 characters' do
      account = build :account, password: 'long' * 7
      account.valid?
      expect(account.errors[:password]).to include 'is too long (maximum is 24 characters)'
    end
  end
end
