source 'https://rubygems.org'
ruby '2.0.0'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'bcrypt-ruby', '3.1.2'
gem "htmlbeautifier", "~> 0.0.9"
gem 'fabrication'
gem 'faker'
gem 'sidekiq'
gem 'unicorn'
gem "sentry-raven"

group :development do
  gem 'sqlite3'
end

group :development, :test, :staging do
  gem 'rspec-rails', '~> 3.0.0.beta'
end

group :staging, :development do
  gem 'pry'
  gem 'pry-nav'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
end

group :test, :staging do
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'capybara-email'
end

group :production, :staging do
  gem 'pg'
  gem 'rails_12factor'
end
