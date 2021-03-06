CarrierWave.configure do |config|
  if Rails.env.development?
    config.storage = :file
    config.enable_processing = true
  elsif Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  else
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'us-west-2'
    }
    config.fog_public = false
    config.fog_directory = 'vcs-projects'
  end
end