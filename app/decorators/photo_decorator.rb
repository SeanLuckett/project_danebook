class PhotoDecorator < SimpleDelegator
  def formatted_upload_date
    created_at.strftime '%B %e, %Y'
  end
end