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

group :development do
  gem 'pry'
  gem 'pry-nav'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :test, :development do
  gem "rspec-rails", "~> 2.0"
end

group :test do
  gem 'shoulda-matchers'
  gem 'fabrication'
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'capybara-email'
  gem 'selenium-webdriver'
end

group :production do
  gem 'rails_12factor'
end
