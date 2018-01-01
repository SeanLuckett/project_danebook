require 'rails_helper'

RSpec.describe 'Commenting on photos', type: :feature do
  let(:user) { create :user }
  before { sign_in user }

  scenario 'User comments on photo' do
    photo = create :photo, user: user
    visit photo_path photo
    fill_in 'comment[body]', with: 'Cool comment, Bro'

    expect {
      click_button 'Comment'
    }.to change(Comment, :count).by(1)

    expect(current_path).to eq photo_path photo
    expect(page).to have_content 'Cool comment, Bro'
  end

  scenario 'User removes own comment from photo' do
    comment = create :comment_for_photo, user: user
    photo = comment.commentable
    photo.update user: user

    visit photo_path photo

    within '.comment' do
      expect {
        click_link 'Delete'
      }.to change(Comment, :count).by(-1)
    end

    expect(current_path).to eq photo_path photo
  end

  scenario 'User fails to remove friend comment from photo' do
    friend = create :user
    user.friended_users << friend

    comment = create :comment_for_photo, user: friend
    photo = comment.commentable
    photo.update user: friend

    visit photo_path photo

    within '.comment' do
      expect(page).not_to have_link 'Delete'
    end
  end
end