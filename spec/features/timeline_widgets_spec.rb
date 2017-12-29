require 'rails_helper'

RSpec.describe 'Photos and Friends widgets', type: :feature do
  let(:user) { create :user }
  before { sign_in user }

  feature 'Viewing the photos widget' do
    context 'User has no photos' do
      scenario 'Shows photo widget with "no photos" message' do
        jimmy = create :user, first_name: 'Jimmy'

        visit timeline_path jimmy
        within '.photos-widget' do
          expect(page).to have_content "#{jimmy.first_name} hasn't uploaded any photos."
        end
      end
    end

    context 'User has between 1 and 9 photos' do
      before do
        2.times { create :photo, user: user }
      end

      scenario 'User timeline shows photo widget with photos' do
        photo = user.photos.first
        visit timeline_path user

        within '.photos-widget' do
          expect(page).to have_content "Photos (#{user.photos.count})"
          expect(page)
            .to have_selector("img[src$='#{photo.file_path.thumb.url}']")
          expect(page).not_to have_link 'See more photos'
        end
      end
    end

    context 'User has more than 9 photos' do
      before do
        10.times { create :photo, user: user }
      end

      scenario 'Photos widget shows a link to more photos' do
        visit timeline_path user

        click_link 'See more photos'
        expect(current_path).to eq photo_list_path user
      end
    end
  end

  feature 'Viewing the friends widget' do
    context 'User has no friends' do
      scenario 'Shows friend widget with "no friends" message' do
        jimmy = create :user, first_name: 'Jimmy'

        visit timeline_path jimmy
        within '.friends-widget' do
          expect(page).to have_content "#{jimmy.first_name} hasn't added any friends."
        end
      end
    end

    context 'User has between 1 and 6 friends' do
      before do
        2.times { user.friended_users << create(:user) }
      end

      scenario 'User timeline shows friend widget with friends' do
        friend = user.friended_users.first
        friend.update(first_name: 'Harry', last_name: 'Henderson')
        visit timeline_path user

        within '.friends-widget' do
          expect(page).to have_content "Friends (#{user.friended_users.count})"
          expect(page).not_to have_link 'See more friends'

          click_link "#{friend.first_name} #{friend.last_name}"
          expect(current_path).to eq timeline_path(friend)
        end
      end
    end

    context 'User has more than 6 friends' do
      before do
        7.times { user.friended_users << create(:user) }
      end

      scenario 'Friends widget shows a link to more friends' do
        visit timeline_path user

        click_link 'See more friends'
        expect(current_path).to eq friends_path user
      end
    end
  end
end