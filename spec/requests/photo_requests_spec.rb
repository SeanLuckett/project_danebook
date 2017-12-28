require 'rails_helper'

RSpec.describe 'Photo requests', type: :request do
  describe 'POST #delete' do
    let(:photo) { create :photo }
    let(:user) { photo.user }

    before { sign_in user.account }

    it 'deletes the photo' do
      expect {
        delete photo_path(photo)
      }.to change(user.photos, :count).by(-1)
    end
  end
end