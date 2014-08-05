require 'raven/sidekiq'

Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.current_environment = 'production'
end
