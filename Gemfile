source 'https://rubygems.org'
ruby '2.0.0'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.1.2'
gem 'bootstrap_form', github: "bootstrap-ruby/rails-bootstrap-forms"
gem 'fabrication'
gem 'faker'
gem 'sidekiq', '3.0.0'
gem 'unicorn'
gem 'carrierwave'
gem 'mini_magick'
gem 'paratrooper'
gem "sentry-raven"
gem "fog"
gem 'figaro'
gem 'stripe'
gem 'draper'
gem 'stripe_event'

group :development do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
end

group :production do
  gem 'pg'
end

group :production, :staging do
  gem 'rails_12factor'
end

group :test, :development do
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
  gem 'capybara-email'
  gem 'vcr'
  gem 'webmock'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
end

