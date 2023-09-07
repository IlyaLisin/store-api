# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 7.0', '>= 7.0.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'bcrypt', '~> 3.1', '>= 3.1.19'
gem 'devise'
gem 'email_validator', '~> 2.2', '>= 2.2.4'
gem 'fast_jsonapi'
gem 'interactor-rails', '~> 2.2', '>= 2.2.1'
gem 'jsonapi_form', '1.0.0', github: 'IlyaLisin/jsonapi_form'
gem 'pg', '~> 1.5', '>= 1.5.4'
gem 'puma', '~> 6.3'
gem 'pundit'
gem 'redis'
gem 'redis-session-store'
gem 'validates_type', '~> 2.1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'debug'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'json-schema'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
end

group :development do
  gem 'annotate', '~> 3.2'
  gem 'listen', '~> 3.8'
end

group :test do
  gem 'json_matchers'
  gem 'rspec-json_expectations'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
