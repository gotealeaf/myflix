source 'https://rubygems.org'
ruby '2.0.0'

gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'coffee-rails'
gem 'rails'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bcrypt-ruby'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'
gem 'unicorn'

group :development do
  gem 'sqlite3'
  gem 'thin'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'fabrication'
  gem 'faker'
  gem 'pry'
  gem 'pry-nav'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
  gem 'capybara-email'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

