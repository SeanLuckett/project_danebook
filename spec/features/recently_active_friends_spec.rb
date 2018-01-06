require 'rails_helper'

RSpec.describe 'Recently active friends on newsfeed', type: :feature do
  let(:user) { create :user, first_name: 'Sarah', last_name: 'Connor' }
  let(:friend) { create :user, first_name: 'Ron', last_name: 'Weasley' }

  scenario 'friend posts recently' do
    user.friended_users << friend
    friend.posts.create body: 'I done posted!', created_at: 2.days.ago

    sign_in user

    within '.recently-active-friends' do
      expect(page).to have_content "#{friend.first_name} #{friend.last_name}"
    end
  end

  scenario 'friend posts not-so-recently' do
    user.friended_users << friend
    friend.posts.create body: 'I done posted!', created_at: 4.days.ago

    sign_in user

    within '.recently-active-friends' do
      expect(page).not_to have_content "#{friend.first_name} #{friend.last_name}"
    end
  end

  scenario 'User does not see own activity' do
    user.friended_users << friend
    friend.posts.create body: 'I done posted!', created_at: 2.days.ago
    user.posts.create body: 'I posted, too!', created_at: 1.day.ago

    sign_in user

    within '.recently-active-friends' do
      expect(page).not_to have_content "#{user.first_name} #{user.last_name}"
    end
  end
end