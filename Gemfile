source 'https://rubygems.org'
ruby '2.1.1'

gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'bcrypt-ruby', '3.1.2'
gem 'fabrication'
gem 'faker'
gem 'mail'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'unicorn'
gem "sentry-raven"
gem 'paratrooper'


group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'pry'
  gem 'pry-nav'
end

group :test do
  gem 'database_cleaner', '1.2.0'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-email'
  gem 'launchy', '~> 2.4.2'
end

group :production do
  gem 'rails_12factor'
end
