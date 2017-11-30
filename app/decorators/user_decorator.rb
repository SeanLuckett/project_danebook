class UserDecorator < SimpleDelegator
  def name
    "#{first_name} #{last_name}"
  end
end