require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Myflix
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.autoload_paths += %W(#{config.root}/lib)
    config.assets.enabled = true
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
      ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
    end
  end
end
