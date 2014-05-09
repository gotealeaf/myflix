CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                       # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],                        # required
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY']                        # required
    #:region                 => 'us-west-2',                  # optional, defaults to 'us-east-1'
    #:host                   => 's3-website-us-west-2.amazonaws.com',             # optional, defaults to nil
    #:endpoint               => 'https://tl-myflix.s3-website-us-west-1.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = 'tl-myflix'                         # required
  config.fog_public     = true                                # optional, defaults to true
end