# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.0'

gem 'pg'
gem 'sinatra'
gem 'rake'

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

group :development, :test do
  gem 'rubocop', '1.20'
end

gem "sinatra-contrib", "~> 2.1"

gem "webrick", "~> 1.7"
