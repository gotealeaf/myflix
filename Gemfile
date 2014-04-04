source 'https://rubygems.org'
ruby '2.0.0'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '~> 4.0.4'
gem 'haml-rails'
gem 'sass-rails', '~> 4.0.2'
gem 'uglifier'
gem 'jquery-rails'
gem "bcrypt-ruby"
gem 'bootstrap_form'
gem 'nokogiri', '1.3.3'

group :development do
  gem 'sqlite3'
  gem 'pry-nav'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'mailgunner', '~> 1.3.0'
end

group :development, :test do
  gem 'fabrication'
  gem "faker"
	gem 'rspec-rails'#, '~> 3.0.0.beta'
  gem 'pry'
  gem 'launchy', '~> 2.4.2'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
end

