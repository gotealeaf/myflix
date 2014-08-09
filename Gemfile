source 'https://rubygems.org'
ruby "2.1.2"


gem 'unicorn'
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem "pg_search"
gem 'bootstrap_form'
gem 'bcrypt', '~> 3.1.7'
gem "figaro"
gem "titleize"
gem 'roadie'
gem 'roadie-rails'
#gem 'kaminari'

gem 'sidekiq'


group :development do
  gem 'pry'
  gem 'pry-nav'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
  gem 'paratrooper'
end

group :development, :test do
  gem 'rspec-rails', '2.99'
  gem 'fabrication'
  gem 'faker'
  gem 'launchy'
  gem 'capybara'
  gem 'capybara-email'
end

group :test do
  gem 'shoulda-matchers', '2.6.0', require: false
  gem 'database_cleaner', '1.2.0'
end

group :production do
  gem 'rails_12factor'
  gem 'informant-rails'
  gem 'newrelic_rpm'
  gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"
end
