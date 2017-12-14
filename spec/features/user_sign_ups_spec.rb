require 'rails_helper'

RSpec.feature "UserSignUps", type: :feature do
  scenario 'user signs up with valid data' do
    visit root_path
    click_link 'Sign up'

    email = "joe.smith@.foobar.com"
    password = 'Foo2Barr'

    fill_in 'Your email', with: email
    fill_in 'Your new password', with: password
    fill_in 'Confirm your password', with: password

    click_button 'Sign up!'
    expect(page).to have_content 'Contact information'
    expect(page).to have_content email
  end

  context 'invalid data' do
    before do
      visit new_account_path
      click_button 'Sign up!'
    end

    scenario 'user fails to sign up' do
      expect(current_path).to eq accounts_path
      expect(page).to have_css '#error_explanation'
    end

    scenario 'page shows error count' do
      expect(page).to have_content '4 errors:'
    end
  end
end
