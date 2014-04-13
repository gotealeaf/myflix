CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],                        # required
      :aws_secret_access_key  => ENV['AWS_SECRET_KEY'],                        # required
      :region                 => 'us-west-2'                   # optional, defaults to 'us-east-1'
      #:host                   => 's3.example.com',             # optional, defaults to nil
      #:endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = 'https://myflixcn.s3.amazonaws.com/'                     # required
    #config.fog_public     = false                                   # optional, defaults to true
  else
    config.storage = :file
    config.enable_processing = Rails.env.development? #does not enable for testing env
  end
end
