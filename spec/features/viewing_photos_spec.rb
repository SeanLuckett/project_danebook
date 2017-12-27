require 'rails_helper'

RSpec.describe 'Viewing photos' do
  let(:user) { create :user }
  before { sign_in user }
  scenario 'signed in user views own, full-sized photo' do
    photo = create :photo, user: user

    visit photo_list_path user
    click_link(href: photo_path(photo))
    expect(current_path).to eq photo_path(photo)
    expect(page).to have_selector("img[src$='#{photo.file_path.url}']")
  end

  scenario "signed in user views friend's, full-sized photo" do
    friend = create :user
    user.friended_users << friend
    photo = create :photo, user: friend

    visit photo_list_path friend
    expect(page).to have_link(href: photo_path(photo))
  end

  scenario 'signed in user cannot unfriend user and still see full-sized photo' do
    friend = create :user
    user.friended_users << friend
    photo = create :photo, user: friend

    visit photo_list_path friend
    click_link(href: photo_path(photo))
    click_link 'Remove friend'
    expect(current_path).to eq photo_list_path friend
  end

  scenario "signed in user cannot view a non-friend's, full-sized photo" do
    non_friend = create :user
    photo = create :photo, user: non_friend

    visit photo_list_path non_friend
    expect(page).to have_selector("img[src$='#{photo.file_path.thumb.url}']")
    expect(page).not_to have_link(href: photo_path(photo))
  end
end