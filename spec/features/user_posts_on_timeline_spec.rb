require 'rails_helper'

RSpec.feature 'User posts timeline', type: :feature do
  context "user's own timeline" do
    let(:post_msg) { 'This is my post.' }

    before do
      user = create :user
      sign_in user
      visit timeline_path user

      fill_in 'post[body]', with: post_msg
      click_button 'Post'
    end

    scenario 'user posts a little something' do
      expect(page).to have_content post_msg
      expect(page.body).to match /Post posted/
    end

    scenario 'user comments on own post' do
      comment_msg = 'This is my comment on my post.'
      fill_in 'comment[body]', with: comment_msg
      click_button 'Comment'

      expect(page).to have_content comment_msg
      expect(page.body).to match /Comment commented/
    end
  end

  context "another user's timeline" do
    scenario 'user comments on post' do
      posting_user = create :user, first_name: 'Fontane'
      create :post, user: posting_user

      comment_msg = 'I comment on your post!'
      logged_in_user = UserDecorator.new(create(:user, first_name: 'Sarah'))
      sign_in logged_in_user

      visit timeline_path(posting_user.id)
      fill_in 'comment[body]', with: comment_msg
      click_button 'Comment'

      expect(page).to have_content comment_msg
      expect(page).to have_content "#{logged_in_user.name} Posted on"
    end
  end
end