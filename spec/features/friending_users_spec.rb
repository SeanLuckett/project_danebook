require 'rails_helper'

RSpec.describe 'Friending/Unfriending', type: :feature do
  let(:visited_user) { create :user, first_name: 'Harry' }
  let(:user) { create :user }

  before { sign_in user }

  scenario 'current user cannot friend self' do
    visit timeline_path(user)
    expect(page).not_to have_link 'Add as friend'
  end

  feature 'friending via timeline' do
    scenario 'Signed in user friends another user' do
      visit timeline_path visited_user
      click_link 'Add as friend'
      expect(current_path).to eq timeline_path visited_user
      expect(page).to have_link 'Remove friend'
    end
  end

  feature 'friending via about/profile page' do
    scenario 'Signed in user friends another user' do
      visit user_path visited_user
      click_link 'Add as friend'
      expect(current_path).to eq user_path visited_user
      expect(page).to have_link 'Remove friend'
    end
  end

  feature 'unfriending via timeline' do
    scenario 'Signed in user unfriends another user' do
      visit timeline_path visited_user
      click_link 'Add as friend'

      click_link 'Remove friend'
      expect(current_path).to eq timeline_path visited_user
      expect(page).to have_link 'Add as friend'
      expect(page)
        .to have_content "You and #{visited_user.first_name} are no longer friends."
    end
  end

  feature 'unfriending via about/profile page' do
    scenario 'Signed in user unfriends another user' do
      visit user_path visited_user
      click_link 'Add as friend'

      click_link 'Remove friend'
      expect(current_path).to eq user_path visited_user
      expect(page).to have_link 'Add as friend'
    end
  end

  scenario "current user can't break another user's friendship" do
    another_friend = create :user
    visited_user.friended_users << another_friend
    visit friends_path visited_user
    expect(page).not_to have_content 'Unfriend me'
  end
end