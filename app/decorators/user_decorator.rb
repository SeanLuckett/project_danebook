class UserDecorator < SimpleDelegator
  def name
    "#{first_name} #{last_name}"
  end

  def formatted_birthdate
    birthdate.strftime '%B %e, %Y'
  end
end