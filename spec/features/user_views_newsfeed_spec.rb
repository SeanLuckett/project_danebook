require 'rails_helper'

RSpec.describe 'User views newsfeed', type: :feature do
  context 'Newsfeed interactions' do
    let(:user) { create :user }
    before { sign_in user }

    scenario 'User sees newsfeed, first, on login' do
      expect(current_path).to eq newsfeed_path(user)
    end

    scenario 'User posts from newsfeed' do
      fill_in 'post[body]', with: 'Post from my newsfeed'
      click_button 'Post'

      expect(current_path).to eq newsfeed_path(user)
    end

    scenario 'User fails to see other newsfeed' do
      other_user = create :user
      visit newsfeed_path other_user
      expect(current_path).to eq newsfeed_path user
    end
  end

  scenario 'User views friend posts' do
    friend1 = create(:post, body: 'This is post 1').user
    friend2 = create(:post, body: 'This is post 2').user
    user = create :user
    user.friended_users << friend1 << friend2

    sign_in user
    expect(page).to have_content friend1.posts.first.body
    expect(page).to have_content friend2.posts.first.body
  end
end