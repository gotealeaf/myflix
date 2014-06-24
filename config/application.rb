require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Myflix
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true

    config.assets.enabled = true
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
    end
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
  "<div class=\"field_with_errors has-error\">#{html_tag}</div>".html_safe
}
  end
end
