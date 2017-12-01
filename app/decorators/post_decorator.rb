class PostDecorator < SimpleDelegator
  def formatted_date
    created_at.strftime '%A, %m %e %Y'
  end
end