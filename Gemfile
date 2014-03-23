source 'https://rubygems.org'
ruby '2.0.0'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'

gem 'bootstrap_form', github: "bootstrap-ruby/rails-bootstrap-forms"
gem "bcrypt-ruby"

group :development do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem 'rspec-rails'
  gem "fuubar"
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
  gem "terminal-notifier-guard"
  gem 'rb-fsevent', require: false
end

group :test do
  gem 'shoulda-matchers'
  gem 'fabrication'
  gem 'faker'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

