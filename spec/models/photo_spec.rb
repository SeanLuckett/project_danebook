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

  describe '#is_liked?' do
    it 'returns true if liked' do
      photo = create :photo
      photo.likes.create user_id: create(:user).id
      expect(photo.reload.is_liked?).to eq true
    end
  end

  describe '#likes_not_by' do
    it 'returns collection minus any belonging to a user' do
      photo = create :photo
      user = photo.user
      photo.likes.create user_id: user.id
      photo.likes.create user_id: create(:user).id

      photo.reload
      expect(photo.likes_not_by(user).map(&:user_id)).not_to include user.id
    end
  end
end
