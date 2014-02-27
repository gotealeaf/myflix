CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                  
      :aws_access_key_id      => ENV['S3_KEY']
      :aws_secret_access_key  => ENV['S3_SECRET']
    }
    config.fog_directory  = 'vivijie'                     # required
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end

