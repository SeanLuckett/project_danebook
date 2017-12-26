require 'rails_helper'

RSpec.describe 'Uploading photos' do
  let(:user) { create :user }
  before { sign_in user }

  scenario 'logged in user looks at list of photos' do
    visit timeline_path user
    click_link 'Photos'
    click_link 'Add photo!'
    expect(page).to have_content 'Select a photo from your hard drive...'
  end

  scenario 'logged in user changes mind about adding photo' do
    visit photo_list_path user
    click_link 'Add photo!'
    click_link 'Cancel'
    expect(current_path).to eq photo_list_path user
  end

  scenario "logged in user looks at another user's photos" do
    visited_user = create :user
    visit photos_path visited_user
    expect(page).not_to have_link 'Add photo!'
  end
end