CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
  
    config.fog_credentials = {
      :provider               => 'AWS',                        
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],   
      :aws_secret_access_key  => ENV['AWS_SECRET_KEY']       
    }
    config.fog_directory  = ENV['S3_BUCKET']                     
  else
    config.storage = :file
    config.enable_processing = Rails.env.development? #so if we are writing tests, we are not using MiniMagick to process the images   
  end
end