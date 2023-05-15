# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby RUBY_VERSION

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'activerecord-sqlserver-adapter', '~> 6.1'
gem 'rails', '~> 6.1.7.3'
gem 'scenic', '~> 1.5', '>= 1.5.4'
gem 'scenic_sqlserver_adapter'

# Reduces boot times through caching; required in config/boot.rb
gem 'bcrypt_pbkdf'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'carrierwave'
gem 'caxlsx'
gem 'cocoon'
gem 'countries'
gem 'devise'
gem 'devise_invitable', '~> 2.0.5', '< 2.0.6' # 2.0.6 breaks the user creation
gem 'dotenv-rails'
gem 'draper'
gem 'dry-validation'
gem 'ed25519'
gem 'interactor'
gem 'kaminari'
gem 'paranoia'
gem 'pundit', '~> 2.1.0'
gem 'rolify'
gem 'tiny_tds'

# Not included by default on Ruby 3+
gem 'rexml', require: false if Gem.ruby_version >= Gem::Version.new('3.0')

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'haml-rails'
gem 'roo'
gem 'roo-xls'
gem 'sass-rails'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'simple_form'

gem 'nokogiri', '>= 1.14.3'
gem 'turbolinks', '~> 5.2.1'

gem 'unicorn'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
gem 'whenever', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'bundler-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'ffaker'
  gem 'listen'
  gem 'pry'
  gem 'rack', '>= 2.2.6.4'
  gem 'rack-mini-profiler'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '< 6.0' # RSpec Rails v6.0.0 drops support for Rails < 6.1
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'webrick'
end

group :development do
  gem 'brakeman'
  gem 'capistrano'
  gem 'capistrano3-unicorn'
  gem 'capistrano-bundler'
  gem 'capistrano-nvm', require: false
  gem 'capistrano-rails'
  gem 'capistrano-rails-console'
  gem 'capistrano-rbenv'
  gem 'capistrano-yarn', require: false
  gem 'letter_opener'
  gem 'rubycritic', require: false
  gem 'solargraph'
  gem 'web-console'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'email_spec', require: false
  gem 'selenium-webdriver'
  gem 'test-prof'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
