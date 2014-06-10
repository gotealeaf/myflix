require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

config = YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
config.merge! config.fetch(Rails.env, {})
config.each do |key, value|
  ENV[key] = value unless value.kind_of? Hash
end unless Rails.env == 'production'

module Myflix
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.autoload_paths << "#{Rails.root}/lib"
    config.action_mailer.default_url_options = { host: ENV['MAILER_HOST'] } unless Rails.env == 'production'

    config.assets.enabled = true
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
    end
  end
end
