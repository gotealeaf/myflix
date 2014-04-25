CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'xxx',
      :aws_secret_access_key  => 'yyy',
    }
    config.fog_directory  = 'name_of_directory'
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end