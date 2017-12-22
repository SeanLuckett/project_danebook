require 'rails_helper'

RSpec.describe 'Viewing user friends lists', type: :feature do
  let(:visited_user) { create :user }
  let(:current_user) { create :user }

  before { sign_in current_user }

  context 'visited user has at least 1 friend' do

    before do
      3.times do |i|
        visited_user.friended_users << create(:user,
                                              first_name: 'Scooby',
                                              last_name: "Doo#{i}")
      end
    end

    scenario 'logged in user visits another user friend list' do
      visit user_path visited_user
      expect(page)
        .to have_content "Friends (#{visited_user.friended_users.count})"

      click_link 'Friends'
      expect(current_path).to eq friends_path(visited_user)

      visited_user.friended_users.each do |friend|
        expect(page).to have_content UserDecorator.new(friend).name
      end
    end
  end
  context 'visited user has at no friends' do

    scenario 'logged in user visits another user friend list' do
      visit user_path visited_user
      expect(page)
        .to have_content 'Friends (0)'

      click_link 'Friends'

      expect(page).to have_content 'Friendless at the moment...'
    end
  end

end