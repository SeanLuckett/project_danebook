class SendWelcomeEmail
  def self.delay_optional(user_id)
    user = User.find(user_id)

    if ENV['ENABLE_DELAYED_EMAILERS'] == 'true'
      UserMailer.welcome(user).deliver_later
    else
      UserMailer.welcome(user).deliver_now
    end
  end
end