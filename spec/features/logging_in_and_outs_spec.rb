require 'rails_helper'

RSpec.feature "LoggingInAndOuts", type: :feature do
  let(:user) { UserDecorator.new(create(:user)) }

  scenario 'user logs in' do
    sign_in user

    expect(current_path).to eq newsfeed_path(user)
    expect(page).to have_content 'You successfully signed in'
  end

  scenario 'user fails log in' do
    visit root_path
    
    fill_in 'Email', with: user.account.email
    fill_in 'Password', with: 'IdoneForgot'
    click_button 'Login'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Failed login'
  end

  scenario 'user logs out' do
    sign_in user
    click_link 'logout'
    expect(current_path).to eq root_path
    expect(page).to have_content 'You have signed out'
  end

end
