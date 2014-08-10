CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['AWS_ID'],                # required
      :aws_secret_access_key  => ENV['AWS_KEY'],               # required
    }
    config.fog_directory  = 'myflix-rottenapple'               # required
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end
