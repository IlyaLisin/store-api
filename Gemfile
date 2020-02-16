source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2'
gem 'puma', '~> 4.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'interactor-rails', '~> 2.0'
gem 'fast_jsonapi'
gem 'devise'
gem 'email_validator', '~> 1.6'
gem 'pundit'
gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem 'redis'
gem 'redis-session-store'
gem 'validates_type', '~> 2.1'


group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'json-schema'
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.8'
  gem 'rubocop-rspec'
  gem 'rubocop', require: false
end

group :development do
  gem 'annotate', '~> 2.7'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'json_matchers'
  gem 'rspec-json_expectations'
  gem 'shoulda-matchers', '~> 3.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
