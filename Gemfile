source 'https://rubygems.org'
ruby '2.0.0'

gem 'bcrypt-ruby'
gem 'bootstrap_form', '2.0.1'
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'haml-rails'
gem 'jquery-rails'
gem 'rails'
gem 'sass-rails'
gem 'sidekiq'
gem 'sinatra', require: nil
gem 'uglifier'
gem 'unicorn'
gem 'paratrooper'


group :development, :test do
  gem 'sqlite3'
  gem 'faker', '~> 1.1.2'
  gem 'pry'
  gem 'pry-nav'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'rspec-rails', '~> 2.14.0'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'guard-rspec', '2.5.0'
  gem 'spork-rails', '4.0.0'
end

group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'launchy', '~> 2.3.0'
  gem 'selenium-webdriver', '~> 2.39.0'
  gem 'shoulda-matchers'
  gem 'fabrication', '1.2.0'
end

group :development do
  gem 'letter_opener'
end

group :production, :staging do
  gem 'pg'
  gem 'rails_12factor'
end

