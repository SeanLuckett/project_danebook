require 'rails_helper'

RSpec.describe 'Liking photos', type: :feature do
  let(:user) { create :user }
  let(:photo) { create :photo, user: user }
  before { sign_in user }

  scenario 'signed in user likes a photo' do
    visit photo_path photo
    click_link 'Like'

    expect(photo.likes.count).to eq 1
    expect(current_path).to eq photo_path(photo)
    expect(page).to have_content "You liked photo by #{photo.user.first_name}!"
    expect(page).to have_content 'You like this.'
  end

  scenario 'signed in user unlikes a photo' do
    visit photo_path photo
    click_link 'Like'
    click_link 'Unlike'

    expect(photo.likes.count).to eq 0
    expect(current_path).to eq photo_path(photo)
    expect(page).to have_content "You unliked photo by #{photo.user.first_name}."
  end
end