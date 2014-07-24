# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Myflix::Application.initialize!
ActionMailer::Base.register_template_extension('haml')