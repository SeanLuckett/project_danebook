require 'rails_helper'

RSpec.feature "LikingPostsAndComments", type: :feature do
  let(:post) { create :post, body: 'My post.' }

  before do
    sign_in post.user
    click_link 'Timeline'
  end

  scenario 'liking a post' do
    click_link 'Like'
    expect(page).to have_content 'You like this.'
  end

  scenario 'liking a comment' do
    create :comment, post: post, body: 'My comment'
    sign_in post.user

    click_link 'Timeline'

    within(:css, '.comment') do
      click_link 'Like'
    end
    within(:css, '.comment') do
      expect(page).to have_content 'You like this.'
    end
  end
end
