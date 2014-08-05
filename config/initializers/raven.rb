require 'raven/sidekiq'

Raven.configure do |config|
  config.action_dispatch.show_exceptions = false
  config.dsn = 'https://15377fda962c46fba061feae971bfb77:fabe1982541f4d049b928bbdb073d6ca@app.getsentry.com/28403'
  config.current_environment = 'production'
end
