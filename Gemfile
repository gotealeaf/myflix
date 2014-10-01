source 'https://rubygems.org'
ruby '2.1.1'

gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'autoprefixer-rails'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bcrypt'
gem 'sidekiq'
gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"
gem 'paratrooper'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'stripe'
gem 'figaro'

group :development do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem 'rspec-rails', '2.99'
  gem 'letter_opener'
end

group :test do
  gem 'database_cleaner', '1.3.0'
  gem 'shoulda-matchers', require: false
  gem 'fabrication'
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
  gem 'vcr'
  gem 'webmock'
  gem 'selenium-webdriver'
  # gem 'capybara-email' waiting for new release cuz open email errors
  gem 'capybara-email', github: 'dockyard/capybara-email'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

