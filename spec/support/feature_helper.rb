module FeatureHelper
  def sign_in(user)
    visit root_path

    fill_in 'Email', with: user.account.email
    fill_in 'Password', with: user.account.password
    click_button 'Login'
  end
end