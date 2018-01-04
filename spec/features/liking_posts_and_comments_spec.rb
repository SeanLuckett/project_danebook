require 'rails_helper'

RSpec.feature "LikingPostsAndComments", type: :feature do
  let(:post) { create :post, body: 'My post.' }

  before do
    sign_in post.user
    visit timeline_path(post.user)
  end

  scenario 'liking a post' do
    click_link 'Like'
    expect(page).to have_content 'You like this.'
  end

  scenario 'liking a comment' do
    comment = create :comment_for_post, body: 'My comment'
    posted = comment.commentable
    sign_in posted.user

    visit timeline_path posted.user

    within(:css, '.comment') do
      click_link 'Like'
    end
    within(:css, '.comment') do
      expect(page).to have_content 'You like this.'
    end
  end
end
