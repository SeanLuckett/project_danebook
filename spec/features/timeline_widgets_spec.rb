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
end