require 'rails_helper'

RSpec.describe Photo, type: :model do
  it 'is invalid without a file_path' do
    photo = build :photo, file_path: nil
    photo.valid?
    expect(photo.errors[:file_path]).to include "can't be blank"
  end

  describe '#liked_by_user?' do
    let(:user) { create :user }
    let(:photo) { create :photo }

    it 'returns true when user likes photo' do
      photo.likes.create user_id: user.id
      expect(photo.liked_by_user?(user)).to eq true
    end

    it 'returns false when user likes photo' do
      expect(photo.liked_by_user?(user)).to eq false
    end
  end
end
