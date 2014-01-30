Myflix::Application.configure do
  config.cache_classes = false
   config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # config.action_mailer.delivery_method = :letter_opener

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  # domain:               'gmail.com',
  user_name:            ENV['GMAIL_USERNAME'],
  password:             ENV['GMAIL_PASSWORD'],
  authentication:       'plain',
  enable_starttls_auto: true  }

 config.action_mailer.default_url_options = { host: 'localhost:3000'}
  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

end
