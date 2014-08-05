require 'raven/sidekiq'

Raven.configure do |config|
  config.action_dispatch.show_exceptions = false
  config.dsn = ENV['SENTRY_DSN']
  config.current_environment = 'production'
end
