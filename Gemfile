source 'https://rubygems.org'
ruby '2.0.0'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.0.1'
gem 'haml-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'sprockets', '2.11.0'
gem 'uglifier'
gem 'jquery-rails'
gem 'bcrypt-ruby', '3.1.2'
gem 'bootstrap_form'
gem 'pg'
gem 'sidekiq'
gem 'redis'
gem 'sinatra', require: false
gem 'slim'
gem 'unicorn'
gem 'sentry-raven'
gem 'paratrooper'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'stripe'
gem 'figaro', '>= 1.0.0.rc1'

group :development do
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
  gem 'pry-debugger'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :test do
  gem "rspec-rails", "~> 2.0"
  gem 'shoulda-matchers'
  gem 'fabrication'
  gem 'faker'
  gem 'capybara'
  gem 'capybara-email'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'vcr'
  gem 'webmock'
end

group :staging, :production do
  gem 'rails_12factor'
end
