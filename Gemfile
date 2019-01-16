source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1', '>= 5.2.1.1'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

###doc [2] set up factory_girl
# DEPRECATION gem 'factory_girl_rails'
gem 'factory_bot_rails', '~> 4.0'

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  ###doc [1] set up rspec and guard
  gem 'rspec-rails', '~> 3.5'
  # then run $ rails generate rspec:install
  gem 'webmock'

  gem 'guard-rspec', require: false
  # then run $ bundle exec guard init rspec

  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
  gem 'capistrano-rvm'
  gem 'capistrano-yarn'

end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'gon'

gem 'dotenv-rails', require: 'dotenv/rails-now'

# rename app
gem 'rename'

group :test do
  ###doc [3] set up shoulda_matchers
  gem 'shoulda-matchers', '~> 3.1'

  ###doc [4] set up faker
  gem 'faker'

  ###doc [5] set up database_cleaner
  gem 'database_cleaner'
end

gem 'seed_migration'

gem 'unicorn', group: [:staging, :production]

#auth
gem 'devise'
gem 'omniauth-identitas'


gem 'pagy'
gem 'simple_form'
gem 'httparty'
