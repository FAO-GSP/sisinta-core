source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1'

# App customization engine
gem 'sislac', github: 'fao-gsp/sislac-extensions'

# Authentication
gem 'devise'
# Authorization
gem 'cancancan'

# Server
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
gem 'actionpack-page_caching'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'dalli'
gem 'whenever', require: false

# Models
gem 'jbuilder', '~> 2.5'
# GIS tools
gem 'rgeo'
gem 'rgeo-geojson'
gem 'activerecord-postgis-adapter'

# UI
gem 'turbolinks', '~> 5'
# CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Templating engine
gem 'haml-rails'
# Basic search features
gem 'ransack'
# Model Decorators
gem 'draper'
# Pagination
gem 'kaminari'
# SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# I18n
gem 'rails-i18n'
gem 'devise-i18n'
gem 'kaminari-i18n'
gem 'i18n_data'
gem 'countries'
gem 'mobility'

# Administration
gem 'activeadmin'

# Data
gem 'kiba'
gem 'kiba-common'
gem 'awesome_print'
# icu, libicu and libicu-dev required
# https://github.com/cowboyd/therubyracer/issues/446#issuecomment-397159092
gem 'charlock_holmes'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'minitest-rails'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'

  # Data creation for tests
  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console'
  # anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Find and manage missing/unused translations
  gem 'i18n-tasks'

  # Deployment
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-config_provider',
    git: 'https://github.com/mauriciopasquier/capistrano-config_provider.git',
    require: false
  # Useful tasks in db, log and tmp namespaces
  gem 'capistrano-rails-collection', require: false
  gem 'capistrano3-delayed-job', require: false
  gem 'capistrano3-puma', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  # Resets db around each tests
  gem 'database_cleaner'
end
