# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'
gem 'dotenv-rails', groups: %i[development test]

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

gem 'pg', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'sidekiq', '<7'
gem 'sidekiq-scheduler'
gem 'sprockets-rails'

gem 'cancancan'
gem 'cocoon', '~> 1.2'
gem 'date_validator', '~> 0.12.0'
gem 'devise'
gem 'hash_dot'
gem 'jbuilder'
gem 'json_validator'
gem 'pagy', '~> 5.10'
gem 'paranoia'
gem 'ransack'
gem 'simple_form', '~> 5.2'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'cssbundling-rails'
gem 'foreman'
gem 'jsbundling-rails'
# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Use Sass to process CSS
# gem "sassc-rails"

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
end

group :development do
  gem 'annotate'
  gem 'bullet'
  gem 'byebug'
  gem 'letter_opener'
  gem 'rubocop-rails', require: false
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
