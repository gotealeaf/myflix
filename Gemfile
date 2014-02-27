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
gem 'bcrypt-ruby'
gem 'figaro'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'stripe'

group :development do
  gem 'sqlite3'
  gem 'thin'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-email'
  gem 'launchy'
  gem 'vcr'
  gem 'webmock', '1.11.0'
  gem 'selenium-webdriver', '2.39.0'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'pry'
  gem 'pry-nav'
  gem 'fabrication'
  gem 'faker'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'unicorn'
end

