# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'pg'
gem 'puma', '~> 3.7'
gem 'rails', '5.1.1'
gem 'redis', '~> 3.0'

# Auth
gem 'bcrypt', '~> 3.1.7'
gem 'doorkeeper'
gem 'validates_email_format_of'

# API
gem 'active_model_serializers'
gem 'rack-cors'

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end
