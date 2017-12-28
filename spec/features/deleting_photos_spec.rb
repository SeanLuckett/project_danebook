require 'rails_helper'

RSpec.describe 'Deleting a photo', type: :feature do
  let(:user) { create :user }
  before { sign_in user }

  scenario 'user deletes own photo' do
    photo = create :photo, user: user
    visit photo_path(photo)
    click_link 'Delete photo'
    expect(current_path).to eq photo_list_path(user)
    expect(page).to have_content 'Deleted photo'
  end

  scenario "user can't delete other user's photo" do
    other_user = create :user
    photo = create :photo, user: other_user
    visit photo_path(photo)

    expect(page).not_to have_link 'Delete photo'
  end
end