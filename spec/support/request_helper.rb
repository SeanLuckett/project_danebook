module RequestHelper
  def sign_in(account)
    post session_path, params: {
      email: account.email, password: account.password
    }
  end
end