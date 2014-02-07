Myflix::Application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              's2-sanjose.accountservergroup.com',
    port:                 465,
    user_name:            ENV['SMTP_USER'],
    password:             ENV['SMTP_PASSWORD'],
    authentication:       'plain',
    enable_starttls_auto: true,
    ssl:                  true
  }
end
