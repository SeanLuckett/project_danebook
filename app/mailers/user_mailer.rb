class UserMailer < ApplicationMailer
  default from: 'danebook@example.com'

  # Subject set in I18n file at config/locales/en.yml

  def welcome(user)
    @greeting = "Hi, #{user.first_name}"

    mail to: user.account.email
  end
end
