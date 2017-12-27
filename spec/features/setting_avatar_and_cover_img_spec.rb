require 'rails_helper'

RSpec.describe 'Setting avatar and cover images', type: :feature do
  let(:user) { create :user }
  before { sign_in user }

  scenario 'user sets photo to avatar/profile' do
    photo = create :photo, user: user
    visit photo_path photo
    click_link 'Set as profile'

    expect(user.reload.avatar).to eq photo.file_path.thumb.url
    expect(current_path).to eq photo_path photo
    expect(page).to have_content 'Set profile photo.'
  end

  scenario 'user fails to set another user photo as avatar/profile' do
    another_user = create :user
    photo = create :photo, user: another_user
    user.friended_users << another_user

    visit photo_path(photo)
    expect(page).not_to have_link 'Set as profile'
  end
end