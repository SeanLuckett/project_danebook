require 'rails_helper'

RSpec.describe 'Recently active friends on newsfeed', type: :feature do
  let(:user) { create :user }
  let(:friend) { create :user, first_name: 'Ron', last_name: 'Weasley' }

  before { sign_in user }

  scenario 'friend posts recently' do
    user.friended_users << friend
    friend.posts.create body: 'I done posted!', created_at: 2.days.ago

    visit newsfeed_path user

    within '.recently-active-friends' do
      expect(page).to have_content "#{friend.first_name} #{friend.last_name}"
    end
  end

  scenario 'friend posts not-so-recently' do
    user.friended_users << friend
    friend.posts.create body: 'I done posted!', created_at: 4.days.ago

    visit newsfeed_path user

    within '.recently-active-friends' do
      expect(page).not_to have_content "#{friend.first_name} #{friend.last_name}"
    end
  end
end