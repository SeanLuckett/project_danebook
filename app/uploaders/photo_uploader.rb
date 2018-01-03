class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog if Rails.env.production?
  process resize_to_fit: [600, 600]

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end

  version :thumb do
    process resize_to_fill: [200, 200]
  end

  def store_dir
    if Rails.env.development?
      "uploads/#{model.class.to_s.underscore}/#{model.id}"
    elsif Rails.env.production?
      "danebook/uploads/#{model.class.to_s.underscore}/#{model.id}"
    else
      'test/fixtures'
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
end
