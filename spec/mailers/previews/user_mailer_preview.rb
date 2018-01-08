# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    account = Account.new(
      email: 'tester@example.com',
      password: 'foo1barr',
      password_confirmation: 'foo1barr'
    )
    account.build_user first_name: 'Tester'
    UserMailer.welcome(account.user)
  end

end
