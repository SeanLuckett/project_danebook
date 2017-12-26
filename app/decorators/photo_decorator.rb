class PhotoDecorator < SimpleDelegator
  def formatted_date
    created_at.strftime '%B %e, %Y'
  end
end