CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['S3_KEY'],                        # required
      :aws_secret_access_key  => ENV['S3_SECRET'],                        # required
    }
    config.fog_directory  = 'name_of_directory'                     # required
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end
