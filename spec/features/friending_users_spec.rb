require 'rails_helper'

RSpec.describe 'Friending', type: :feature do
  let(:visited_user) { create :user }
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
end