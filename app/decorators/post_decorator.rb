class PostDecorator < SimpleDelegator
  def formatted_date
    created_at.strftime '%A, %m/%-d/%Y'
  end
end